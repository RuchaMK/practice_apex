/*Prob 1:
 * Prevent Duplicates on Contact 
1.No duplicate 
2.Duplicates allowed but not within same account
use  row locking (FOR UPDATE)
This can be made using workflow but it fails for undelete case or if unrelated field is updated.
Solution:
1. Make a list using trigger.new - newContactEmails.
2. Query ExistingContactList by checking existingContactEmails in database.
Here take email to check duplicates.
Prob 2:
Prevent deuplicate contacts on same account
*/
        trigger ContactTrigger on Contact (before insert, before update,after undelete) {
            if(Trigger.isBefore && (Trigger.isUpdate || Trigger.isInsert)){
                	ContactTriggerHandler.preventDuplicateContacts(Trigger.New, Trigger.oldMap); //prob1
                    ContactTriggerHandler.preventDuplicateConOnAcc(Trigger.New);//prob2
                  
            }
            
            if(Trigger.isAfter && Trigger.isUndelete){
                 ContactTriggerHandler.preventDuplicateContacts(Trigger.New, Trigger.oldMap);
                 ContactTriggerHandler.preventDuplicateConOnAcc(Trigger.New);
            }
           
        }

/*
 Prob1: List<Contact> conList = new List<Contact>();
for(Integer i =0 ; i<3;i++){
    conList.add(new Contact(LastName='test',Email='Test1@t.com'));
}
conList.add(new Contact(LastName='test',Email='Test10@t.com'));
insert conList;

Prob2:
List<Contact> conList = new List<Contact>();
for(Integer i =0 ; i<3;i++){
    conList.add(new Contact(LastName='test',Email='Test1@t.com',AccountId='0015j00000nA80KAAS'));
}
conList.add(new Contact(LastName='test',Email='Test10@t.com'));
insert conList;

*/