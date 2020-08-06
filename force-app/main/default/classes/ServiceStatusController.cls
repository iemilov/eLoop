/**
 * @File Name          : ServiceStatusController.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 1/8/2020, 5:31:11 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    7/22/2019, 10:02:03 AM   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
public without sharing class ServiceStatusController {
    
    @AuraEnabled(cacheable = true)
    public static List<CaseHistory> fetchsObjectData(String caseId){
        List<CaseHistory> listCases= [SELECT Case.Id, Case.CaseNumber, CreatedDate, NewValue  FROM CaseHistory where field ='Status' AND Case.Id=:CaseId order by CreatedDate desc];
        return listCases;
    }
    
    //System.debug(ServiceStatusController.fetchsObjectData('5002E00001Sqrq1'));

    @AuraEnabled(cacheable = true)
    public static List<Unterstatus__c> getComments (String caseId, String status){
        List<Unterstatus__c> comments= [SELECT Id, createdDate, ImgUrl__c, ConvertedDate__c, relatedCaseStatus__c, Kommentar__c  from Unterstatus__c where Case__c =:caseId and relatedCaseStatus__c =:status order by CreatedDate desc];
        for(Unterstatus__c comment: comments) {
            comment.ConvertedDate__c = comment.CreatedDate.format('dd.MM.yyyy hh:mm');
        }

        return comments;
    }

    @AuraEnabled(cacheable = true)
    public static Case getCaseNumber (String caseId){
        Case caseObj= [SELECT Id, CaseNumber from Case where Id =:caseId];
        return caseObj;
    }
    
    //System.debug(ServiceStatusController.getCaseNumber('5002E00001Sqrq1'));

    @AuraEnabled(cacheable = true)
    public static List<ContentVersion> getImages (String caseId, String status) {
        List<Id> contentIds = new List<Id>();
        for (ContentDocumentLink cont :[SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :caseId]) {
            contentIds.add(cont.ContentDocumentId);
        }
        List<ContentVersion> bodyList = [SELECT id, ContentDocumentId, ImgUrl__c, Title FROM ContentVersion where ContentDocumentId IN :contentIds AND relatedCaseStatus__c=:status];

        return bodyList;    
    }
//System.debug(ServiceStatusController.getImages('5002E00001SqBEV', 'Gerät ist angekommen'));
    @AuraEnabled
    public static ServiceFormular__c createServiceFormular(ServiceFormular__c formular, String email) {
        
        String ErrorMessage='Die eingegebene Email-Adrresse gibt es nicht! Bitte benutzen Sie die gleiche Email, mit der Sie die Reparatur gekauft haben';
        //String EmailFromLWC = formular.Contact__c;
        String EmailFromLWC = email;

        List<Contact> conList = [select Id from Contact where Email=:EmailFromLWC];
        List<Case> caseList = [select Reparatur__c from Case where id=:formular.Case__c];
        ServiceFormular__c processedFormular = new ServiceFormular__c();

        if (conList.size()>0) {
            processedFormular.Contact__c = conList.get(0).Id;
            processedFormular.Case__c = formular.Case__c;
            processedFormular.Reparatur__c = caseList.get(0).Reparatur__c;
            processedFormular.Hersteller_Modell__c = formular.Hersteller_Modell__c;
            processedFormular.Seriennummer__c = formular.Seriennummer__c;
            processedFormular.Fehlerbeschreibung__c = formular.Fehlerbeschreibung__c;
            processedFormular.ReparaturInAndererWerkstatt__c = formular.ReparaturInAndererWerkstatt__c;
            processedFormular.WarVorigeReparaturErfolgreich__c = formular.WarVorigeReparaturErfolgreich__c;
            processedFormular.FestgestellteDiagnose__c = formular.FestgestellteDiagnose__c;
            processedFormular.GeraetIstGestuerzt__c = formular.GeraetIstGestuerzt__c;
            processedFormular.FluessigkeitenAufDasGeraet__c = formular.FluessigkeitenAufDasGeraet__c;
            processedFormular.EintrittDesDfektesUmstaende__c = formular.EintrittDesDfektesUmstaende__c;
            processedFormular.WeitereBekannteDefekte__c = formular.WeitereBekannteDefekte__c;
            
            insert processedFormular;
            return processedFormular;
        } else {
            //processedFormular.Response__c = ErrorMessage;
            // handover the error through the system in the catch path in the LWC
            processedFormular.Contact__c = ErrorMessage;
            return processedFormular;
        }
        
        /*try {  
			insert ser;
        } catch(Exception e) {
            ExceptionHandler.logException('EmailMessageControllerHelper', 'createServiceFormular', e.getMessage(), e.getLineNumber());
        }*/
    }
}

// if you use rich text
/*List<Case> campList = [SELECT Id, RichField__c FROM Case where Id ='5002E00001SqBEVQA3'];

for (Case camp: campList){

    String firstSubString = camp.RichField__c.substringBetween('<img', 'img>');
    System.debug('First substring: ' + firstSubString);

    String secondSubString = firstSubString.substringBetween('src="', '"');
    System.debug('Second substring: ' + secondSubString);

    String link = secondSubString.replace('amp;', '');
    System.debug('Link: ' + link);
}
*/