/**
 * @File Name          : generateImgLinkHandler.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 1/7/2020, 3:04:54 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    7/22/2019, 4:50:15 PM   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
public with sharing class generateImgLinkHandler {

        public static ContentDistribution generatePublicLink (Id id) {

            //get the contentDocumentId based on the content
            ContentVersion cv = [select id, title, ContentDocumentId from contentversion where Id =:Id];

            ContentDistribution cd = new ContentDistribution();
            cd.Name = cv.title;
            cd.ContentVersionId = cv.id;
            cd.PreferencesAllowViewInBrowser= true;
            cd.PreferencesLinkLatestVersion=true;
            cd.PreferencesNotifyOnVisit=false;
            cd.PreferencesPasswordRequired=false;
            cd.PreferencesAllowOriginalDownload= true;

            try {  
                insert cd;
        	} catch(Exception e) {
                ExceptionHandler.logException('generateImgLinkHandler', 'generatePublicLink', e.getMessage(), e.getLineNumber());
        	}
            addImgLinkAndRelatedStatus(id);

        return cd;
        }

        private static void addImgLinkAndRelatedStatus (Id id) {

            ContentVersion cv = [select relatedCaseStatus__c, ContentDocumentId, ImgUrl__c, FirstPublishLocationId from ContentVersion where id=:id];
            Case relatedCase = [select Id, Status from Case where Id=:cv.FirstPublishLocationId];

            ContentDistribution cd = [SELECT ContentDownloadUrl FROM ContentDistribution where ContentDocumentId=:cv.ContentDocumentId];
            
            cv.relatedCaseStatus__c = relatedCase.Status;
            cv.ImgUrl__c = cd.ContentDownloadUrl;

            try {  
                update cv;

                // send email to the related contact if new picture is added
                sendEmail(relatedCase.Id);

        	} catch(Exception e) {
                    ExceptionHandler.logException('generateImgLinkHandler', 'addImgLinkAndRelatedStatus', e.getMessage(), e.getLineNumber());
        	}

        }

        private static void sendEmail (Id caseId) {

            Case relatedCase = [select Id, Status_Link__c, Contact.Name, ContactEmail, Status from Case where Id=:caseId];
            
            String htmlBody = 'Sehr geehrte(r) Herr/Frau ' + relatedCase.Contact.Name + ','  + '<br><br>' + ' zum Status Ihrer Reparatur wurde ein Kommentar hinzugefügt:<p>'+
            '<a href='+relatedCase.Status_Link__c+'>Clicken Sie hier!</a>' + '<br> <br>' +
            'Mit freundlichem Gruß </br>' +
            'Ihr Team von electronic loop Reparatur & Service';
            String subject ='Der Status Ihrer Reparatur hat sich geändert';

            String[] toAddresses = new String[] {relatedCase.ContactEmail};

            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(toAddresses);
            mail.setSubject(subject);
            mail.setHtmlBody(htmlBody);
            mail.setSaveAsActivity(false);
            mail.setUseSignature(false);

            List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
            allmsg.add(mail);

            try {
                Messaging.sendEmail(allmsg,false);
                return;
            } catch (Exception e) {
                ExceptionHandler.logException('generateImgLinkHandler', 'sendEmail', e.getMessage(), e.getLineNumber());
            }
        }

        //
        
        /*private void changeSharingType (Id id) {

        }*/
}
