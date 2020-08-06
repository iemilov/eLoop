/**
 * @File Name          : TestDataFactory.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 1/8/2020, 4:22:47 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    7/10/2019, 11:31:42 AM   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/

//@isTest
public class TestDataFactory{

    public static String Subject = 'Herzlichen Glückwunsch, Ihr Artikel Fujitsu Lifebook N532 Mainboard Reparatur NAPA (192395515) wurde verkauft';
    public static String CaseOrigin = 'Email';

    public static String TextBody =  'Herzlichen Glückwunsch, www-electronicloop-de - Ihr Artikel wurde verkauft! Verschicken Sie Ihren Artikel bitte *innerhalb von 1 Tagen* nach Eingang der Zahlung. Bereiten Sie den Versand vor <https://rover.ebay.com/rover/0/e12011.m354.l1337/7?euid=ac5b171445ca4d9d9522258fe3d92f38&loc=https%3A%2F%2Fwww.ebay.de%2Flbr%2Fgo%3Ft%3D192395515575-1622419159009%26ssPageName%3DADME%3AL%3AEOISSA%3ADE%3A1337> Mit eBay-Versandetiketten können Sie Versandetiketten einfach und kostengünstig erwerben und Sendungsinformationen automatisch hochladen. Wenn Sie kein eBay-Versandetikett verwenden, laden Sie die Sendungsinformationen bitte manuell hoch oder markieren Sie Ihren Artikel in Mein eBay als verschickt. *Das wäre alles. Sie haben es geschafft!* Meine verkauften Artikel <http://my.ebay.de/ws/eBayISAPI.dll?MyEbayBeta&CurrentPage=MyeBayMyAccounts&FClassic=true&ssPageName=STRK:ME:MAX&_trksid=p3984.m2295.l3911> [image: Fujitsu Lifebook N532 Mainboard Reparatur Repair NAPA] <https://rover.ebay.com/rover/0/e12011.m43.l1123/7?euid=ac5b171445ca4d9d9522258fe3d92f38&loc=http%3A%2F%2Fcgi.ebay.de%2Fws%2FeBayISAPI.dll%3FViewItem%26item%3D192395515575%26ssPageName%3DADME%3AL%3AEOISSA%3ADE%3A1123> Artikelbezeichnung: Fujitsu Lifebook N532 Mainboard Reparatur Repair NAPA <https://rover.ebay.com/rover/0/e12011.m43.l1123/7?euid=ac5b171445ca4d9d9522258fe3d92f38&loc=http%3A%2F%2Fcgi.ebay.de%2Fws%2FeBayISAPI.dll%3FViewItem%26item%3D192395515575%26ssPageName%3DADME%3AL%3AEOISSA%3ADE%3A1123> Nutzername des Verkäufers: www-electronicloop-de Angebotsende: 06.05.19 15:57:13 MESZ Preis: EUR 124,99 Stückzahl: 12 Verkaufte Stückzahl: 1 Käufer: Bernd Neuhoff billis_gehtnix (is.emilov@gmail.com) [Käufer kontaktieren <http://contact.ebay.de/ws/eBayISAPI.dll?ReturnUserEmail&requested=billis_gehtnix&redirect=0&iid=192395515575> ] Angemeldete Adresse des Käufers: Bernd Neuhoff Amselsstrasse 1a 41564 Kaarst Deutschland Bitte beachten Sie, dass die Lieferadresse eine andere sein kann. Sobald der Käufer die Kaufabwicklung abgeschlossen hat, senden wir Ihnen die Lieferadresse per E-Mail zu. Wenn Ihr Käufer nicht innerhalb von 3 Tagen gezahlt hat, erhält er eine Zahlungserinnerung. <https://rover.ebay.com/rover/0/e12011.m44.l1337/7?euid=ac5b171445ca4d9d9522258fe3d92f38&loc=https%3A%2F%2Fwww.ebay.de%2Flbr%2Fgo%3Ft%3D192395515575-1622419159009%26ssPageName%3DADME%3AL%3AEOISSA%3ADE%3A1337> Wir wünschen Ihnen weiterhin viel Erfolg mit eBay. Weitere Informationen finden Sie in Mein eBay <http://my.ebay.de/>. ------------------------------ E-Mail-Referenznummer: [#ac5b171445ca4d9d9522258fe3d92f38#] ------------------------------ Mehr zum Thema Schutz vor betrügerischen E-Mails <http://pages.ebay.de/education/spooftutorial/index.html>. eBay hat Ihnen diese E-Mail an ebay@electronicloop.de hinsichtlich des von Ihnen bei www.ebay.de angemeldeten eBay-Kontos gesendet. eBay sendet Ihnen regelmäßig die erforderlichen Benachrichtigungen für die Website und Ihre Transaktionen. Bei Fragen lesen Sie bitte unsere Datenschutzerklärung <http://pages.ebay.de/help/policies/privacy-policy.html> und die Nutzungsbedingungen <http://pages.ebay.de/help/policies/user-agreement.html> . Diese E-Mail wurde Ihnen von der eBay Europe S.à r.l. gesendet, die durch Ihre Tochtergesellschaften den eBay-Service bereit stellt. Wenn sich Ihr Wohnsitz nicht innerhalb der Europäischen Union befindet, lesen Sie bitte die Information zu Ihrem Vertragspartner in den Allgemeinen Geschäftsbedingungen (AGB). Copyright © 2019 eBay Inc. Alle Rechte vorbehalten. Warenzeichen und Marken sind Eigentum der jeweiligen Inhaber. Der Name eBay und das eBay-Logo sind Eigentum von eBay Inc. eBay-Impressum <http://pages.ebay.de/aboutebay/contact.html>.';
    public static String EmailAddress = TextBody.substringAfter('(').substringBefore(')').trim();
    public static String Address = TextBody.substringAfter('Angemeldete Adresse des Käufers:').substringBefore('Bitte').trim();
    public static String FirstName = 'Cool';
    public static String LastName = 'Dude';
    
    //@isTest
    public static EmailMessage createEmailMessage(String FromAddress) {

        EmailMessage emailObject = new EmailMessage();
        emailObject.Subject = Subject;
        emailObject.TextBody = TextBody;
        emailObject.FromAddress = FromAddress;
        emailObject.RelatedToId = createCase().Id;
        

        try {
            insert emailObject;
        }
        catch(Exception e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        return emailObject;  
    }

    //@isTest
    public static Case createCase() {

        Case caseObject = new Case();
        caseObject.Origin = CaseOrigin;
        caseObject.Status='New';
        insert caseObject;
        return caseObject;
    }

    /*@isTest
    public static EmailMessage updateRepairNameOnEmailMessage() {
        
        // first create new EmailMessage with new Case
        EmailMessage emailMessage=createEmailMessage();

        String NewRepairName = 'Herzlichen Glückwunsch, www-electronicloop-de - Ihr Artikel wurde verkauft! Verschicken Sie Ihren Artikel bitte *innerhalb von 1 Tagen* nach Eingang der Zahlung. Bereiten Sie den Versand vor <https://rover.ebay.com/rover/0/e12011.m354.l1337/7?euid=ac5b171445ca4d9d9522258fe3d92f38&loc=https%3A%2F%2Fwww.ebay.de%2Flbr%2Fgo%3Ft%3D192395515575-1622419159009%26ssPageName%3DADME%3AL%3AEOISSA%3ADE%3A1337> Mit eBay-Versandetiketten können Sie Versandetiketten einfach und kostengünstig erwerben und Sendungsinformationen automatisch hochladen. Wenn Sie kein eBay-Versandetikett verwenden, laden Sie die Sendungsinformationen bitte manuell hoch oder markieren Sie Ihren Artikel in Mein eBay als verschickt. *Das wäre alles. Sie haben es geschafft!* Meine verkauften Artikel <http://my.ebay.de/ws/eBayISAPI.dll?MyEbayBeta&CurrentPage=MyeBayMyAccounts&FClassic=true&ssPageName=STRK:ME:MAX&_trksid=p3984.m2295.l3911> [image: Fujitsu Lifebook N532 Mainboard Reparatur Repair NAPA] <https://rover.ebay.com/rover/0/e12011.m43.l1123/7?euid=ac5b171445ca4d9d9522258fe3d92f38&loc=http%3A%2F%2Fcgi.ebay.de%2Fws%2FeBayISAPI.dll%3FViewItem%26item%3D192395515575%26ssPageName%3DADME%3AL%3AEOISSA%3ADE%3A1123> Artikelbezeichnung: MacBook Repair NAPA <https://rover.ebay.com/rover/0/e12011.m43.l1123/7?euid=ac5b171445ca4d9d9522258fe3d92f38&loc=http%3A%2F%2Fcgi.ebay.de%2Fws%2FeBayISAPI.dll%3FViewItem%26item%3D192395515575%26ssPageName%3DADME%3AL%3AEOISSA%3ADE%3A1123> Nutzername des Verkäufers: www-electronicloop-de Angebotsende: 06.05.19 15:57:13 MESZ Preis: EUR 124,99 Stückzahl: 12 Verkaufte Stückzahl: 1 Käufer: Bernd Neuhoff billis_gehtnix (is.emilov@gmail.com) [Käufer kontaktieren <http://contact.ebay.de/ws/eBayISAPI.dll?ReturnUserEmail&requested=billis_gehtnix&redirect=0&iid=192395515575> ] Angemeldete Adresse des Käufers: Bernd Neuhoff Amselsstrasse 1a 41564 Kaarst Deutschland Bitte beachten Sie, dass die Lieferadresse eine andere sein kann. Sobald der Käufer die Kaufabwicklung abgeschlossen hat, senden wir Ihnen die Lieferadresse per E-Mail zu. Wenn Ihr Käufer nicht innerhalb von 3 Tagen gezahlt hat, erhält er eine Zahlungserinnerung. <https://rover.ebay.com/rover/0/e12011.m44.l1337/7?euid=ac5b171445ca4d9d9522258fe3d92f38&loc=https%3A%2F%2Fwww.ebay.de%2Flbr%2Fgo%3Ft%3D192395515575-1622419159009%26ssPageName%3DADME%3AL%3AEOISSA%3ADE%3A1337> Wir wünschen Ihnen weiterhin viel Erfolg mit eBay. Weitere Informationen finden Sie in Mein eBay <http://my.ebay.de/>. ------------------------------ E-Mail-Referenznummer: [#ac5b171445ca4d9d9522258fe3d92f38#] ------------------------------ Mehr zum Thema Schutz vor betrügerischen E-Mails <http://pages.ebay.de/education/spooftutorial/index.html>. eBay hat Ihnen diese E-Mail an ebay@electronicloop.de hinsichtlich des von Ihnen bei www.ebay.de angemeldeten eBay-Kontos gesendet. eBay sendet Ihnen regelmäßig die erforderlichen Benachrichtigungen für die Website und Ihre Transaktionen. Bei Fragen lesen Sie bitte unsere Datenschutzerklärung <http://pages.ebay.de/help/policies/privacy-policy.html> und die Nutzungsbedingungen <http://pages.ebay.de/help/policies/user-agreement.html> . Diese E-Mail wurde Ihnen von der eBay Europe S.à r.l. gesendet, die durch Ihre Tochtergesellschaften den eBay-Service bereit stellt. Wenn sich Ihr Wohnsitz nicht innerhalb der Europäischen Union befindet, lesen Sie bitte die Information zu Ihrem Vertragspartner in den Allgemeinen Geschäftsbedingungen (AGB). Copyright © 2019 eBay Inc. Alle Rechte vorbehalten. Warenzeichen und Marken sind Eigentum der jeweiligen Inhaber. Der Name eBay und das eBay-Logo sind Eigentum von eBay Inc. eBay-Impressum <http://pages.ebay.de/aboutebay/contact.html>.';

        EmailMessage updateBody = [SELECT Id, TextBody FROM EmailMessage WHERE Id=:emailMessage.Id];
        updateBody.TextBody = NewRepairName;
        update updateBody;

        return updateBody;
    }*/
}