/**
 * @File Name          : ServiceStatusControllerTest.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 1/8/2020, 4:40:07 PM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    12/20/2019   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/

@isTest
public with sharing class ServiceStatusControllerTest {

    public static EmailMessage emailObj = TestDataFactory.createEmailMessage('ebay@ebay.de');

    @isTest
    static void GetCaseHistoryTest() {
        ServiceStatusController.fetchsObjectData(emailObj.ParentId);
        //System.assertEquals(ServiceStatusController.fetchsObjectData(CaseId).get(0).Case.Id, 'Bestellung ist eingegangen');
    }

    @isTest
    static void getCommentsTest() {

        Case caseObj = [select Id, ContactId, Status, Kommentar__c from Case where Id=:emailObj.RelatedToId];
        caseObj.Kommentar__c='Bah mamu';
        caseObj.UpdateRelationToCaseCompleted__c = true;
        update caseObj;
        ServiceStatusController.getComments(caseObj.Id, caseObj.Status);
    }

    @isTest
    static void getCaseNumberTest() {

        Id caseId = TestDataFactory.createCase().Id;
        ServiceStatusController.getCaseNumber(caseId);
    }

    @isTest
    static void getImagesTest() {

        Id CaseId = generateImgLinkTriggerTest.generatePublicLinkTest();
        ServiceStatusController.getImages(CaseId, 'New');
    }
        
    /*@isTest
    static void createServiceFormularTest() {

        Id CaseId = emailObj.ParentId;  
        ServiceFormular__c formularObj = new ServiceFormular__c();
        formularObj.Case__c=CaseId;
        ServiceStatusController.createServiceFormular(formularObj, 'is.emilov@gmail.com');
    }*/
}

/*

    EmailMessage emailObj = TestDataFactory.createEmailMessage('ebay@ebay.de');
    Id CaseId = emailObj.ParentId;
    System.debug('tatatatdadada '+ CaseId);
    ServiceFormular__c formularObj = new ServiceFormular__c();
    formularObj.Case__c= CaseId;
    ServiceStatusController.createServiceFormular(formularObj, 'is.emilov@gmail.com');


    select Reparatur__c from Case where id='5002E00001VSQSvQAP'
*/