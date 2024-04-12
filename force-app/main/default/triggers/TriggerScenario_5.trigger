// Whenever Lead is created with lead Source as WEB then give rating as COLD otherwise HOT 
trigger TriggerScenario_5 on Lead (before insert) {
    for(Lead lead : Trigger.New){
        if(lead.LeadSource == 'Web'){
            lead.Rating = 'Cold';
        }
        else
            lead.Rating = 'Hot';
    }
}