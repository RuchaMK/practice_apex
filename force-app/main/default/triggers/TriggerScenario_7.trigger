/*Conditional Creation of Child
Trigger to create a related Contact on Account with same Phone as Account if custom field checkbox is checked on Account*/
trigger TriggerScenario_7 on Account (after insert, after update) {
    //global static Integer i=0; static var connot be used in trigger context use it in handler
    if(Trigger.new != null){
        List<Contact> finalContact = new List<Contact>();
        
        for(Account acc: Trigger.new){
            if(acc.createChild__c &&  Trigger.isInsert){
                Contact con = new Contact(AccountId = acc.id, LastName = 'insertCon', Phone = acc.Phone );
                finalContact.add(con);
            }
            else if(Trigger.isUpdate && Trigger.oldMap!=null && Trigger.oldMap.get(acc.Id).createChild__c != true){   
                Contact con = new Contact(AccountId = acc.id, LastName = 'updateCon', Phone = acc.Phone);
               // i+=1;
                finalContact.add(con);
            
            }
        }
     
        if(finalContact.size()>0){
            insert finalContact;
        }
    }
}