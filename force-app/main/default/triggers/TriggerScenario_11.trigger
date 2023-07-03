/*C-P MD: Develop an Apex trigger that sets the Account owner as the default opportunity owner for newly created Opportunities.*/
trigger TriggerScenario_11 on Opportunity (after insert) {
    Set<Id> accId = new Set<Id>();
    if(!Trigger.new.isEmpty()){
        for(Opportunity op : Trigger.new){
        	accId.add(op.AccountId);
        }
        List<Opportunity> finalUpdate = new List<Opportunity>();
        if(accId.size() > 0){
            for(Account acc: [SELECT ID,OwnerId,(SELECT Id,OwnerId from Opportunities) from Account where Id IN: accId]){
                for(Opportunity op : acc.Opportunities){
                    op.OwnerId = acc.OwnerId;
                    finalUpdate.add(op);
                }
            }
        }
        if(finalUpdate != null){
            update finalUpdate;
        }
    }
}