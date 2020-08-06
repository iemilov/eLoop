/**
 * @File Name          : EmailMessageControllerHelper.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 1/13/2020, 5:03:13 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    7/9/2019, 2:52:41 PM   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
public with sharing class EmailMessageControllerHelper {

    public String ProcessPointer1;
    public String ProcessPointer2;
    public String ProcessPointer3;
    public String ProcessPointer4;
    public String ProcessPointer5;
    public String ProcessPointer6;
    public String CurrentEmailBody;
    public String PersonalData;
    public String FirstName;
    public String LastName;
    public String Address;
    public String EmailAddress;
    public String Name;
    public String Price;
    public String RelateEmailMessage;


    public void processEmail (List <EmailMessage> currentMessages) {

        for (EmailMessage body: currentMessages) {
            RelateEmailMessage = body.RelatedToId;
            ProcessPointer1=getProcessPointer1(body.TextBody);
            ProcessPointer2=getProcessPointer2(body.TextBody);

            PersonalData = body.TextBody.substringAfter(ProcessPointer1).substringBefore(ProcessPointer2).trim().normalizeSpace();
            String[] PersonalDataList = PersonalData.split(' ');
            ProcessPointer6 = getProcessPointer6(body.TextBody); 

            if (body.FromAddress=='ebay@ebay.de' || body.FromAddress=='iemilov@salesforce.com' ) {
                FirstName = PersonalDataList.get(0);
                LastName= PersonalDataList.get(1);
                Address= PersonalData.substringAfter(PersonalDataList.get(1)).substringBefore(ProcessPointer2).trim();
                //ProcessPointer6 = getProcessPointer6(body.TextBody);  
                EmailAddress = getEmail(body.TextBody.substringAfter(ProcessPointer6).substringBefore(ProcessPointer2).trim());
                Name = body.Subject.substringAfter('Artikel').substringBefore('(').trim();
            }
            else if (body.FromAddress=='service@electronicloop.de'){
                FirstName = PersonalDataList.get(1);
                LastName= PersonalDataList.get(2);
                Address= PersonalData.substringAfter(PersonalDataList.get(2)).substringBefore(ProcessPointer2).trim();
                //ProcessPointer6 = getProcessPointer6(body.TextBody);
                EmailAddress = getEmail(body.TextBody.substringAfter(ProcessPointer1).substringBefore(ProcessPointer6).trim());
                ProcessPointer5=getProcessPointer5(body.TextBody);
                Name = getReparaturName(body.TextBody, ProcessPointer5);
            }

            if(Test.isRunningTest()){
                EmailAddress = 'example@gmail.com';
            }else if (body.FromAddress == 'iemilov@salesforce.com') {
                EmailAddress = 'is.emilov@gmail.com';
            }
            else {
                EmailAddress = 'danil@web.de';
            }
            
            ProcessPointer3=getProcessPointer3(body.TextBody);
            ProcessPointer4=getProcessPointer4(body.TextBody);
            Price=body.TextBody.substringAfter(ProcessPointer3).substringBefore(ProcessPointer4).trim();
            String Geraet = Name.substringBefore('Rep').trim();

            //create contact record
            Map<String, String> c = new Map<String, String>();
            c.put('FirstName', FirstName);
            c.put('LastName', LastName);
            c.put('Email', EmailAddress);
            c.put('RelateEmailMessageId', RelateEmailMessage);
            c.put('AddressCustomer', Address);
            createContactRecord(c);

            //create product record
            Map<String, String> p = new Map<String, String>();
            p.put('Name', Name);
            p.put('Price', Price);
            p.put('RelatedCaseId', RelateEmailMessage);
            p.put('Geraet', Geraet);
            createProductRecord(p);

            /*System.debug('FirstName is ' + FirstName);
            System.debug('LastName is ' + LastName);
            System.debug(EmailAddress);
            System.debug(RelateEmailMessage);
            System.debug(Address);
            System.debug(Name);
            System.debug(Price);
            System.debug(Geraet);*/

        }
    }

    private static String getReparaturName(String body, String ProcessPointer5){
        
        String ProcessReparaturName = body.substringAfter(ProcessPointer5).substringBefore('EUR').trim();
        String[] ProcessReparaturNameList = ProcessReparaturName.split(' ');


        String Reparatur = '';
        for (integer i=0;i<ProcessReparaturNameList.size();i++) {
            
            if (i>0 && i < ProcessReparaturNameList.size()-2 ) {
                //System.debug(ProcessReparaturNameList.get(i).trim());
                Reparatur = Reparatur + ' ' + ProcessReparaturNameList.get(i).trim();
            }
        }
        return Reparatur;
    }

    private static String getProcessPointer1(String body){
        
        String Variable;
        if (body.contains('Your billing adress')){
            Variable='Your billing adress:';
        } else if (body.contains('Rechnungsadresse:')) {
            Variable='Ihre Rechnungsadresse:';
        } else if (body.contains('Angemeldete Adresse des Käufers')) {
            Variable='Angemeldete Adresse des Käufers:';
        } else {
            Variable='nix';
        }

        return Variable;
    }
    
//select id, createdDate, fromaddress, TextBody from emailmessage order by createddate desc

    private static String getProcessPointer2(String body){
        
        String Variable;
        if (body.contains('Mobil')){
            Variable='Mobil';
        } else if (body.contains('Tel')) {
            Variable='Tel';
        } else if (body.contains('Bitte beachten Sie')) {
            Variable='Bitte beachten Sie';
        } else if (body.contains('Herzlichen Glückwunsch, Ihr Artikel')) {
            Variable='Herzlichen Glückwunsch, Ihr Artikel';
        } else {
            Variable='Email';
        }

        return Variable;
    }

    private static String getProcessPointer3(String body){
        
        String Variable;
        if (body.contains('Total')){
            Variable='Total:';
        } else if (body.contains('Gesamtsumme')) {
            Variable='Gesamtsumme:';
        }
        else if (body.contains('Preis')) {
            Variable='Preis:';
        }

        return Variable;
    }

   private static String getProcessPointer4(String body){
        
        String Variable;
        if (body.contains('Your billing adress')){
            Variable='Your billing adress:';
        } else if (body.contains('Ihre Rechnungsadresse')) {
            Variable='Ihre Rechnungsadresse:';
        }
        else if (body.contains('Stückzahl')) {
            Variable='Stückzahl:';
        }

        return Variable;
    }

    
    private static String getProcessPointer5(String body){
        
        String Variable;
        if (body.contains('consists of the following items')){
            Variable='consists of the following items:';
        } else if (body.contains('folgende Positionen')) {
            Variable='folgende Positionen:';
        }
        else if (body.contains('Artikelbezeichnung')) {
            Variable='Artikelbezeichnung:';
        }

        return Variable;
    }

    private static String getProcessPointer6(String body){
        
        String Variable;
        if (body.contains('You have chosen the following payment option')){
            Variable='You have chosen the following payment option:';
        } else if (body.contains('Lieferadresse ist gleich Rechnungsadresse')) {
            Variable='Lieferadresse ist gleich Rechnungsadresse';
        }
        else if (body.contains('Lieferadresse ist gleich Rechnungsadresse')) {
            Variable='Lieferadresse ist gleich Rechnungsadresse';
        }
        else if (body.contains('Käufer')) {
            Variable='Käufer:';
        }

        return Variable;
    }
    

    public void createContactRecord(Map<String, String> contactParams){
        
        Contact con = new Contact();
        
        con.FirstName = contactParams.get('FirstName');
        con.LastName = contactParams.get('LastName');
        con.Email = contactParams.get('Email');
        con.RelatedToEmailMessageId__c = contactParams.get('RelateEmailMessageId');

        // should be refactored
        con.KaeuferAdresse__c = contactParams.get('AddressCustomer');

		List<Contact> conList = new List<Contact>();
        //conList = [SELECT Id FROM Contact WHERE Email=:contactParams.get('Email')];
        conList = [SELECT Id FROM Contact WHERE LastName=:contactParams.get('LastName')];
        
        if (conList.size() > 0) {
            try {  
			    //'there is already a contact with this email' The same record will be updated with the new relatedcaseId coming from the Emailmessage object
                //Contact conObj = [SELECT RelatedToEmailMessageId__c FROM Contact WHERE Email=:contactParams.get('Email')];
                Contact conObj = [SELECT RelatedToEmailMessageId__c FROM Contact WHERE LastName=:contactParams.get('LastName')];
                conObj.RelatedToEmailMessageId__c = contactParams.get('RelateEmailMessageId');
                update conObj;

        	} catch(Exception e) {
                ExceptionHandler.logException('EmailMessageControllerHelper', 'createContactRecord', e.getMessage(), e.getLineNumber());
        	}
        }
        else {
        	try {
				insert con;
        	} catch(Exception e) {
                ExceptionHandler.logException('EmailMessageControllerHelper', 'createContactRecord', e.getMessage(), e.getLineNumber());
        	}
        }
    }

    public void createProductRecord(Map<String, String> productParams){
        
        Reparatur__c prod = new Reparatur__c();
        
        prod.Name__c = productParams.get('Name');
        prod.RelatedCaseId__c = productParams.get('RelatedCaseId');
        prod.Preis__c = productParams.get('Price');
        prod.Geraet__c = productParams.get('Geraet');

		List<Reparatur__c> prodList = new List<Reparatur__c>();
        prodList = [SELECT Id FROM Reparatur__c WHERE Name__c=:productParams.get('Name__c')];


        if (prodList.size() > 0) {
            try {  
			    //'there is already a product with this name' The same record will be updated with the new relatedcaseId coming from the Emailmessage object
                Reparatur__c updateProduct = [SELECT RelatedCaseId__c FROM Reparatur__c WHERE Name__c=:productParams.get('Name__c')];
                updateProduct.RelatedCaseId__c = productParams.get('RelatedCaseId');
                update updateProduct;
                
        	} catch(Exception e) {
                ExceptionHandler.logException('EmailMessageControllerHelper', 'createProductRecord', e.getMessage(), e.getLineNumber());
        	}
        }
        else {
        	try {  
				insert prod;
        	} catch(Exception e) {
                ExceptionHandler.logException('EmailMessageControllerHelper', 'createProductRecord', e.getMessage(), e.getLineNumber());
        	}
        }
        
    }

    public void deleteNotRelevantCases(List <EmailMessage> currentMessage) {

        List<Case> caseListToDelete = [SELECT id FROM Case WHERE id =:currentMessage.get(0).RelatedToId];
        try {  
			delete caseListToDelete;
        } catch(Exception e) {
            ExceptionHandler.logException('EmailMessageControllerHelper', 'deleteNotRelevantCases', e.getMessage(), e.getLineNumber());
        }
        
    }

    private static String getEmail(String Body) {

        String bam;

        Matcher m = Pattern.compile('[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+').matcher(Body);
        while (m.find()) {
            bam = m.group();
        }
        return bam;
    }
}