/*1. Add Account Phone in corresponding contact Phone*/

trigger AccountUpdateTrigger on Account (after insert, after update) {
    List<Contact> updatingContacts = new List<Contact>();
    List<Account> updatedAccounts = [Select Id,Phone, (Select Id,Phone from Contacts) from Account where Id in :Trigger.new];
    for(Account acc: updatedAccounts){
        List<Contact> conList = acc.Contacts;
        for(Contact con: conList){
     
            con.Phone = acc.Phone;
            updatingContacts.add(con);
            
        }
    }
    
    if(!updatingContacts.isEmpty()){
        update updatingContacts;
    }
}