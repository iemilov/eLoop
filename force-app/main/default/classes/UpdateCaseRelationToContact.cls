/**
 * @File Name          : UpdateCaseRelationToContact.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 8/1/2019, 1:47:58 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    7/9/2019, 3:35:26 PM   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
public with sharing class UpdateCaseRelationToContact {
    
    @InvocableMethod
	public static void UpdateCaseRelationsToContact(List<Id> ConIds){
        
        List<Contact> conObj = new List<Contact>();
        
        conObj = [SELECT Id, RelatedToEmailMessageId__c FROM Contact WHERE id=:ConIds];

        /*List<Case> caseList = new List<Case>();
        caseList = [SELECT Id FROM Case WHERE id='5002E00001OdkCDQAZ'];
        
        System.debug(caseList);*/

		Case caseObject = [SELECT Id FROM Case WHERE id=:conObj.get(0).RelatedToEmailMessageId__c];
        caseObject.ContactId = conObj.get(0).Id;

        try {  
            update caseObject;
        } catch(Exception e) {
                ExceptionHandler.logException('UpdateCaseRelationToContact', 'UpdateCaseRelationsToContact', e.getMessage(), e.getLineNumber());
        }
    }
}