/**
 * @File Name          : generateImgLinkTriggerTest.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 1/7/2020, 4:10:08 PM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    1/7/2020   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/

@isTest
public with sharing class generateImgLinkTriggerTest {

    @isTest
    public static Id generatePublicLinkTest() {

        Id caseId = TestDataFactory.createCase().Id;

        String base64 = 'Unit Test Attachment Body';

        ContentVersion cv = new ContentVersion();
        cv.VersionData = EncodingUtil.base64Decode(base64);
        //cv.VersionData = EncodingUtil.base64Decode(EncodingUtil.urlEncode('Unit Test Attachment Body','UTF-8'));
        cv.Title = 'ABC';
        cv.PathOnClient = 'ABC';
        cv.FirstPublishLocationId = caseId;
        insert cv;

        return caseId;

    }
}