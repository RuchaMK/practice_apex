/*Trigger to count OpportunityLineItem(Grandchild) whose ListPrice is greater than 50,000$ 
associated with Opportunity(Parent) and display that count on Account's(GrandParent) custom field.
 Account's(GrandParent)-> Opportunity(Parent) -> OpportunityLineItem(Grandchild)
*/
trigger TriggerScenario_22 on OpportunityLineItem (after insert, after delete) {
    Set<Id> oppIds  = new Set<Id>();
    List<Opportunity> opList = new List<Opportunity>();
    Map<Id,Decimal> countMap = new Map<Id,Decimal>(); //accountId, count
    Decimal oliCount = 0;
    Id accId = null;
    List<Account> toUpdateAcc = new List<Account>();
    
    if(Trigger.isInsert){
        for(OpportunityLineItem opLI : Trigger.new){
            oppIds.add(opLI.OpportunityId);//parentId
        }
    }
    
    if(Trigger.isDelete){
        for(OpportunityLineItem opLI : Trigger.old){
            oppIds.add(opLI.OpportunityId);//parentId
        }
    }
       
    if(!oppIds.isEmpty()){//query Parent
        opList = [Select Id, AccountId from Opportunity where Id in : oppIds];      
    }
    
    if(!opList.isEmpty()){
        for(Opportunity op : opList){
            countMap.put(op.AccountId,0);
        } 
    }
    
    AggregateResult[] aggrList = [Select count(Id) oliCount,Opportunity.AccountId from OpportunityLineItem 
                                 where Opportunity.AccountId != null and Opportunity.AccountId in : countMap.keySet()
                                 and ListPrice > 50000 Group BY Opportunity.AccountId];
    
    for(AggregateResult aggr : aggrList){
        accId = (Id)aggr.get('AccountId');//sf automatically assigns
        oliCount = (Decimal)aggr.get('oliCount');
        countMap.put(accId,oliCount);//parent,count       
    }
    
    for(Id id : countMap.keySet()){
        Account acc = new Account(Id = id, Number_of_Products__c = oliCount);
        toUpdateAcc.add(acc);
    }    
    
    if(!toUpdateAcc.isEmpty()){
        update toUpdateAcc;
    }
       
}