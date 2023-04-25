//Count number of contacts on Account using trigger 
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
    
    
}