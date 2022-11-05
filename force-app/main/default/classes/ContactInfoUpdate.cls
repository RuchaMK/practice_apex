/*Updating Contact Mailing details as Account Mailing details*/
global class ContactInfoUpdate implements Database.Batchable<Sobject>{
    global Database.QueryLocator start(Database.BatchableContext db){
        
        return Database.getQueryLocator(
        'Select id,BillingStreet,BillingCity,'+
        'BillingPostalCode,(Select id,MailingStreet,MailingCity,'+
        'MailingState,MailingPostalCode FROM Contacts) FROM Account'
        
        );
    }
    
    global void execute(Database.BatchableContext db, List<Account> accList){
        List<Contact> contacts = new List<Contact>();
        for(Account acc:accList){
            for(Contact con:acc.contacts){
                con.MailingStreet = acc.BillingStreet;
                con.MailingCity = acc.BillingCity;
//                con.MailingCountry = acc.BillingCountry;
                con.MailingPostalCode = acc.BillingPostalCode;
                contacts.add(con);
            }
        }
           update contacts;        
    }
    
    global void finish(Database.BatchableContext db){}
}

/*
ContactInfoUpdate updateObj = new ContactInfoUpdate();
Database.executeBatch(updateObj);

*/