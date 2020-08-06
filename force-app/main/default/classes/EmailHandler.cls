/**
 * Email services are automated processes that use Apex classes
 * to process the contents, headers, and attachments of inbound
 * email.
 */
global class EmailHandler implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,
    Messaging.InboundEnvelope envelope) {

        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();

		String subToCompare = 'Create Contact';

		if(email.subject.equalsIgnoreCase(subToCompare)) {
			Contact c = new Contact();
			c.LastName = email.plainTextBody;
			insert c;
		}

	    result.success = true;
        System.debug(result);
        return result;
    }
}
