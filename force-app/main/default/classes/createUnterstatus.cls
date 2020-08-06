/**
 * @File Name          : createUnterstatus.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 1/7/2020, 4:16:22 PM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    12/11/2019   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
public with sharing class createUnterstatus {

    public static void createUnterstatus(Id id) {
        List<Case> caseList = [select Id, Kommentar__c, Status from Case where Id=:id];
        List<Unterstatus__c> unterStatusList =  new List<Unterstatus__c>();
        Unterstatus__c unterStatus = new Unterstatus__c();
        
        for(Case c: caseList) {
            unterStatus.Kommentar__c = c.Kommentar__c;
            unterStatus.Case__c = c.Id;
            unterStatus.relatedCaseStatus__c = c.Status;
            unterStatusList.add(unterStatus);
        }
        insert unterStatusList;
    }
}
