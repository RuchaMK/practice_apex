/* Opportunity , OpportunityLineItem - 
Whenever Opportunity status is closed lost, closed won we want to restrict dml on opportunity line item */
trigger TriggerScenario_24 on 	OpportunityLineItem (before insert) {
    Set<Id> oppId = new Set<Id>();
    
    for(OpportunityLineItem oli : Trigger.newMap.values()){
        if(oli.Opportunity.StageName == 'Closed Won'){
            oli.addError('DML not allowed');
        }
    }
}