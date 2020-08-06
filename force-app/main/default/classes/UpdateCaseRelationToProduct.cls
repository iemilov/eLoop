/**
 * @File Name          : UpdateCaseRelationToProduct.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 7/30/2019, 10:16:51 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    7/22/2019, 10:36:40 AM   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
public class UpdateCaseRelationToProduct {

    @InvocableMethod
	public static void UpdateCaseRelationsProduct(List<Id> ProductIds){
        
        List<Reparatur__c> prodObj = new List<Reparatur__c>();
        
        prodObj = [SELECT Id, Name__c, RelatedCaseId__c FROM Reparatur__c WHERE id=:ProductIds];
        
        List<Case> caseList = [SELECT Id, UpdateRelationToCaseCompleted__c FROM CASE WHERE id=:prodObj.get(0).RelatedCaseId__c];
        List<Case> updatedCaseList = new List<Case>();
        caseList[0].Reparatur__c = prodObj.get(0).Id;
        // this will trigger the class "generatePDFController"
        caseList[0].UpdateRelationToCaseCompleted__c = true;
        updatedCaseList.add(caseList[0]);
        try {  
            update updatedCaseList;
        } catch(Exception e) {
                ExceptionHandler.logException('UpdateCaseRelationToProduct', 'UpdateCaseRelationsProduct', e.getMessage(), e.getLineNumber());
        }




        /*try {
            Database.SaveResult[] srList = Database.update(caseList, false);

            // Iterate through each returned result
            for (Database.SaveResult sr : srList) {
                if (sr.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully updated Case. Case ID: ' + sr.getId());
                    SetCaseRecordToCompleted.UpdateRecord(sr.getId());
                }
            }
        } catch(Exception e) {
            System.debug('The following exception has occurred on upserting case: ' + e.getMessage());
        }*/
    }
}