/*Create a field Opportunity amount on Account object and write a trigger on Opportunity to populate 
the total sum of all opportunity Amount on Account Object Opportunity amount field*/
trigger TriggerScenario_9 on Opportunity ( after insert, after update, after delete) {
   Map<Id,Opportunity> updatedOpportunity = new  Map<Id,Opportunity>();
    if(!Trigger.isDelete ){
        for(Opportunity op : Trigger.new){
           
               updatedOpportunity.put(op.AccountId,op);   
            
        }
    }
    if(Trigger.isDelete){
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
                        
                                       		
                       
                           
                            system.debug('&&'+totalAmount);
                        
                    }
                }
                acc.TotalOpportunity__c = totalAmount;
                 finalUpdate.add(acc);
            }
        }
        if(finalUpdate.size()>0){
            update finalUpdate;
        }

    
}