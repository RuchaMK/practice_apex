// Prevent Account from deleting if it has 2 or more contacts..
trigger TriggerScenario_3 on Account (before delete) {
   if(true) return;
    List<Account> accList = [SELECT Id, (Select Id FROM Contacts) FROM Account where Id in :Trigger.old ];
    if(accList != null){
        system.debug('Contact Size' + accList);
        for(Account a : Trigger.Old){
        for(Account acc: accList){
            if(acc.Contacts.size() >= 2){
                a.addError('Prevent Account from deleting if it has 2 or more contacts');
            }
        }
    }
    }

}

/*
When using a before delete trigger, the records are still available in Trigger.old, but any modifications to the records themselves are not saved 
to the database. This means that if you want to prevent the deletion of records based on certain conditions, you need to add an error 
to the records in Trigger.old
*/