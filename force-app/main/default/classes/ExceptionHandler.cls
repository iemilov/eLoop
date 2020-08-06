/**
 * @File Name          : ExceptionHandler.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 7/30/2019, 9:51:33 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    7/30/2019, 2:57:02 PM   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
public with sharing class ExceptionHandler {


    //Save exception in custom object log
    public static void logException(String className, String methodName, String description, Integer lineNumber){
        Error_Log__c log = new Error_Log__c();
        log.Class_Name__c = className;
        log.Method_Name__c = methodName;
        log.Error_Description__c = description;
        log.Type__c = 'Error';
        log.Line_Number__c = lineNumber;
        
        insert log;
    }
}
