/*Create a field Opportunity amount on Account object and write a trigger on Opportunity to populate 
the total sum of all opportunity Amount on Account Object Opportunity amount field*/
trigger TriggeronOpportunity on Opportunity (after insert, after update, after delete) {
    Set<Id> accountIds = new Set<Id>();

    if (!Trigger.isDelete) {
        for (Opportunity op : Trigger.new) {
            accountIds.add(op.AccountId);
        }
    } else {
        for (Opportunity op : Trigger.old) {
            accountIds.add(op.AccountId);
        }
    }

    List<Account> accountsToUpdate = new List<Account>();

    for (AggregateResult ar : [
        SELECT AccountId, SUM(Amount) totalAmount
        FROM Opportunity
        WHERE AccountId IN :accountIds
        AND Amount != null
        GROUP BY AccountId
    ]) {
        Account acc = new Account(
            Id = (Id)ar.get('AccountId'),
            TotalOpportunity__c = (Decimal)ar.get('totalAmount')
        );
        accountsToUpdate.add(acc);
    }

    if (!accountsToUpdate.isEmpty()) {
        update accountsToUpdate;
    }
}

/*trigger TriggerScenario_9 on Opportunity ( after insert, after update, after delete) {
   Map<Id,Opportunity> updatedOpportunity = new  Map<Id,Opportunity>();
    if(!Trigger.isDelete ){
        for(Opportunity op : Trigger.new){
           
               updatedOpportunity.put(op.AccountId,op);   
            
        }
    }
    else{
        for(Opportunity op: Trigger.old){
              updatedOpportunity.put(op.AccountId,op);
        } 
    }
        List<Account> finalUpdate = new List<Account>();
         if(updatedOpportunity.size() > 0){
            for(Account acc : [SELECT Id,TotalOpportunity__c, (SELECT Amount  from Opportunities) from Account where Id IN : updatedOpportunity.keySet()]){
               Double totalAmount = 0;
                for(Opportunity op: acc.Opportunities){
                    if(op.Amount!=null){
                           system.debug('##only insert');
                           totalAmount += op.Amount;
		                   //system.debug('&&'+totalAmount);
                    }
                }
                acc.TotalOpportunity__c = totalAmount;
                 finalUpdate.add(acc);
            }
        }
        if(finalUpdate.size()>0){
            update finalUpdate;
        }
/*
    for (AggregateResult ar : [
       SELECT AccountId, SUM(Amount) totalAmount
       FROM Opportunity
       WHERE AccountId IN :updatedOpportunity.keySet()
       AND Amount != null
       GROUP BY AccountId
    ]) {
       Account acc = new Account(
          Id = (Id) ar.get('AccountId'),
          TotalOpportunity__c = (Decimal) ar.get('totalAmount')
       );
       finalUpdate.add(acc);
    }


    
}*/