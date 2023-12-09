/* Opportunity , OpportunityLineItem - 
Whenever Opportunity status is closed lost, closed won we want to restrict dml on opportunity line item */
trigger TriggerScenario_24 on 	OpportunityLineItem (before insert) {
    Set<Id> oppId = new Set<Id>();
    
    for(OpportunityLineItem op : Trigger.newMap.values()){
        if(op.Opportunity.StageName == 'Closed Won'){
            oppId.add(op.Opportunity.Id);
        }
    }
}