/*You have a custom object called "Opportunity__c" with a field named "Stage__c". Whenever an Opportunity record is updated
to change the Stage to "Closed Won", you need to create a new "Revenue__c" record with the same amount as the Opportunity's "Amount__c" field.*/
trigger TriggerScenario_10 on Opportunity__c (after update){
    if(Trigger.new != null){
        List<Revenue__c> revList = new List<Revenue__c>();
        for(Opportunity__c op : Trigger.new){
            if(op.Stage__c == 'Closed Won'){        
                revList.add(new Revenue__c(Name='rev', Amount__c = op.Amount__c));
            }
        }
        insert revList;
    }
}