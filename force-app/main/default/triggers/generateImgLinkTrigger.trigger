/**
 * @File Name          : generateImgLinkTrigger.trigger
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 7/22/2019, 5:26:12 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    7/22/2019, 5:12:11 PM   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
trigger generateImgLinkTrigger on ContentVersion (after insert) {
        //This trigger will share all Chatter files with Community Users
    for(ContentVersion cv:Trigger.new) {
        if(cv.ContentDocumentId != null){
            generateImgLinkHandler.generatePublicLink(cv.Id);
        }
    }
}