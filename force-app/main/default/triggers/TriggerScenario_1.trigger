//Count number of contacts on Account using trigger 
/*TriggerScenario_1 Roll Up Summary - Count number of contacts on Account using trigger .*/
trigger TriggerScenario_15 on Contact (before insert, before update, after delete, after undelete) {
    Set<Id> accId = new Set<Id>();

    if(!Trigger.new.isEmpty()){
        for(Contact con : Trigger.new){
            accId.(con.AccountId);
        }
    }
    if(!Trigger.old.isEmpty()){
        for(Contact con : Trigger.old){
            accId.(con.AccountId);
        }
    }
    List<Account> accList = [Select Id, (Select Id from Contacts) from Account where Id in: accId];
    List<Contact> toUpdateAcc = new List<Contact>();
    if(!accList.isEmpty()){
        for(Account acc: accList){
            acc.Count__c = acc.Contacts.size();
            toUpdateAcc.add(acc);
        }
    }
    if(!toUpdateAcc.isEmpty()){
        update toUpdateAcc;
    }
}
/*==========================v1====================================
trigger TriggerScenario_1 on Contact (after insert, after update, after delete, after undelete) {
    if(true) return;
	try{Set<Id> accIdList = new Set<Id>(); //Add rel acc id of all contacts updated
   
    if(Trigger.Old !=null){ //only old is available in Delete trigger
        for(Contact con: Trigger.Old){
            accIdList.add(con.AccountId);
        }
    }
     if(Trigger.New !=null){
        for(Contact con: Trigger.New){
            accIdList.add(con.AccountId);
        }
    }
    
    //Get all details of Acc Id in unique set
    //P-C query using subquery
    List<Account> accList = [SELECT Id, ContactCount__c, (SELECT Id from Contacts) FROM Account WHERE Id in :accIdList];
    
    //Find related Contact size
    if(accList != null){
        for(Account acc: accList){
            acc.ContactCount__c = acc.Contacts.size();
        }
        
        update accList;
    }
       }catch(Exception e){
           
           system.debug('Exception:' + e.getMessage() + e.getLineNumber() + e.getStackTraceString());
       }
    
    
}*/
