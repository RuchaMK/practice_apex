//Count number of contacts on Account using trigger 
/*TriggerScenario_1 Roll Up Summary - Count number of contacts on Account using trigger .*/
trigger TriggerScenario_1 on Contact (after insert, after update, after delete, after undelete) {
	Set<Id> accSet = new Set<Id>();
    List<Account> toUpdateAccount = new List<Account>();
    //insert
    if(Trigger.isInsert || Trigger.isUndelete){
        for(Contact con : Trigger.New){
            if(con.AccountId != null){
                accSet.add(con.AccountId);
            }
        }
    }
    //update
      if(Trigger.isUpdate){
        for(Contact con : Trigger.New){
            if(con.AccountId != Trigger.oldMap.get(con.Id).AccountId){
                accSet.add(con.AccountId);
                accSet.add(Trigger.oldMap.get(con.Id).AccountId);
            }
        }
    }
    //delete
      if(Trigger.isDelete){
        for(Contact con : Trigger.old){
			  accSet.add(con.AccountId);
        }
    }
    
    if(!accSet.isEmpty()){
        //Select AccountId accId, COUNT() from Contact group by AccountId --gives all
        for(AggregateResult agr : [Select AccountId accId, COUNT(Id) contactSize from Contact 
                                   where AccountId in : accSet GROUP BY AccountId]){
            Account acc = new Account();
            acc.Id = (Id)agr.get('accId');
            acc.Total_Contacts__c = (Integer)agr.get('contactSize');
            toUpdateAccount.add(acc);
        } 
    }
    
    if(!toUpdateAccount.isEmpty()){
        try{
            update toUpdateAccount;
        }catch(Exception ex){
            system.debug('Exception: '+ex.getMessage());
        }        
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
