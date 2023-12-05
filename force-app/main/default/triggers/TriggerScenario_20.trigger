/*
Whenever Escalation Required checkbox gets checked for a Case on an Account a 
follow up task is automatically created for the Primary contact on Account.
Case - Account - Primary Contact
Custom Fields: Case : Escalation Required 
	       Contact : Primary Contact
Context: after insert
*/
trigger TriggerScenario_20 on Case (after insert,after update) {
    Set<Id> accountIdsOnCase = new Set<Id>();
    List<Contact> contactsToUpdate = new List<Contact>();
    List<Task> newTasks = new List<Task>();
     
    for(Case cs : Trigger.new){
        if(cs.Escalation_Required__c){
            accountIdsOnCase.add(cs.AccountId);
        }    
    }
    system.debug('accountIdsOnCase'+accountIdsOnCase);
    if(!accountIdsOnCase.isEmpty()){
        contactsToUpdate = [Select Id,OwnerId from Contact where AccountId != null and AccountId in : accountIdsOnCase and Primary_Contact__c = true];
    }
    system.debug('contactsToUpdate'+accountIdsOnCase);
    if(!contactsToUpdate.isEmpty()){
        for(Contact con : contactsToUpdate){
            Task tsk = new Task();
            tsk.WhoId = con.Id;
            tsk.Priority = 'Low';
            tsk.Status = 'Completed';
            tsk.Subject = 'CallPre';
            //tsk.OwnerId = con.OwnerId;
            newTasks.add(tsk);
        }
    }
     system.debug('newTasks'+accountIdsOnCase);
    if(!newTasks.isEmpty()){
        insert newTasks;
    }

}