/**
 * @File Name          : PDFController.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 12/16/2019, 2:24:01 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    7/11/2019, 11:32:42 AM   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
global class PDFController {

    @future(callout=true)
    public static void manageAttachment(String CaseId){

        List<Attachment> attachmentToDelete = [SELECT id FROM Attachment WHERE Name = 'ServiceFormular.pdf'];

        if (attachmentToDelete.size() > 0) {
            try {  
				delete attachmentToDelete;
                createAttachment(CaseId);
        	} catch(Exception e) {
                ExceptionHandler.logException('PDFController', 'manageAttachment', e.getMessage(), e.getLineNumber());
        	}
        } 
        else {
           createAttachment(CaseId);
        }
    }

    public static void createAttachment(String CaseId){
        List<Case> currentCase = new List<Case>();
        currentCase= [select Id, Status FROM Case where id=:CaseId];
        pageReference pdf = Page.ServiceFormular;    
        pdf.getParameters().put('id',currentCase.get(0).Id);
        Blob body;
        if(Test.isRunningTest()){
            body = blob.valueOf('test');
        }else {
            body = pdf.getContentAsPDF();
        }

        List<EmailTemplate> RightEmailTemp = [select Id from EmailTemplate where Name='Bestellungseingang'];

        Attachment[] attachmentList = new List<Attachment>{
            new Attachment(Body=body, Name = String.valueOf('ServiceFormular.pdf'), ParentId = RightEmailTemp.get(0).Id)
        };
        
        Database.SaveResult[] srList = Database.insert(attachmentList, false);

        for (Database.SaveResult sr : srList) {
            if (sr.isSuccess()) {
                Case caseUpdate= [select Id FROM Case where id=:CaseId];
                caseUpdate.Status= 'Bestellung ist eingegangen';
                update caseUpdate;
            }
            else {
            // Operation failed, so get all errors                
                for(Database.Error err : sr.getErrors()) {
                    ExceptionHandler.logException('PDFController', 'createAttachment', err.getMessage(), 0);
                }
            }
        }
    }
}