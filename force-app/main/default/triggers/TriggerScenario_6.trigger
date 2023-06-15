/*Update Parent Whenever a contacts description is updated then its parent account's description should get updated by related contact desc.*/
trigger TriggerScenario_6 on Contact (after update) {
    Map<Id,Contact> updatedConAcc = new Map<Id,Contact>();
    if(!Trigger.new.isEmpty()){
        for(Contact con: Trigger.new){
            if(Trigger.oldMap != null && Trigger.oldMap.get(con.Id).Description != con.Description){
            	updatedConAcc.put(con.AccountId,con);
            }
        }        
    }
    List<Account> finalUpdate = new List<Account>();
    if(!updatedConAcc.isEmpty()){
        for(Account acc: [SELECT Id From Account where Id IN :updatedConAcc.keySet()]){
            acc.Description = updatedConAcc.get(acc.Id).Description;
         	finalUpdate.add(acc);
        }      
    }
    
    if(finalUpdate.size() > 0){
        update finalUpdate;
    }

}