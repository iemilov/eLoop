/**
 * @File Name          : EmailMessageController.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 12/18/2019, 3:19:02 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    7/9/2019, 2:58:14 PM   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
public with sharing class EmailMessageController {
    
    @InvocableMethod
	public static void ProcessEmailMessageRecord(List<Id> EmailMessageIds){

        String EmailComesFromEbay = 'ebay@ebay.de';
        String EmailComesFromShop = 'service@electronicloop.de';
        
        List<EmailMessage> currentMessage = new List<EmailMessage>();

		currentMessage= [select FromAddress, Subject, Id, TextBody, RelatedToId FROM EmailMessage where id=:EmailMessageIds];
        EmailMessageControllerHelper processor = new EmailMessageControllerHelper();
        
        if (currentMessage.get(0).FromAddress == EmailComesFromShop || 
            currentMessage.get(0).FromAddress == EmailComesFromEbay||
            currentMessage.get(0).FromAddress == 'iemilov@salesforce.com' &&
            !currentMessage.get(0).Subject.contains('wurde erfolgreich auf eBay eingestellt')) {
            processor.processEmail(currentMessage);
        }
        /*if (currentMessage.get(0).FromAddress == EmailComesFromShop || currentMessage.get(0).FromAddress == 'iemilov@salesforce.com'){
            processor.processEmailShop(currentMessage);
        }
        //temporary solution
        else if (currentMessage.get(0).FromAddress == EmailComesFromEbay) {
            processor.processEmailEbay(currentMessage);
        }*/
        
        else {
            processor.deleteNotRelevantCases(currentMessage);
        }
    }
}
