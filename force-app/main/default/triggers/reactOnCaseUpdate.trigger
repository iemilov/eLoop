/**
 * @File Name          : reactOnCaseUpdate.trigger
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 12/11/2019, 7:26:46 PM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    12/11/2019   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
trigger reactOnCaseUpdate on Case (after update) {
    if (Trigger.isUpdate) {
        if (Trigger.isAfter) {
            // Process after update of UpdateRelationToCaseCompleted__c field
            for(Case c: Trigger.new){
                Case oldCase = trigger.oldMap.get(c.Id);
                if (c.UpdateRelationToCaseCompleted__c != oldCase.UpdateRelationToCaseCompleted__c) {
                    PDFController.manageAttachment(c.Id);
                }
                if (c.Kommentar__c != oldCase.Kommentar__c) {
                    createUnterstatus.createUnterstatus(c.Id);
                }
            }
        }
    }
}