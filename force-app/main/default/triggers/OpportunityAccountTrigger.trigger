/*
Roll Up Summary Count Child records in lookup and update on Parent record
Accpunt has lookup on Opportunity , find the opportunity which has maximum number of amount and then populate that opportunity in Account record in Top opportunity field
*/
trigger OpportunityAccountTrigger on Opportunity(after update, after insert){
    if(Trigger.isInsert || Trigger.isUpdate){
      List<Account> accList = new List<Account>();
      for(Opportunity op: Trigger.New){
        if(op.AccountId != null){
                Account acc = [SELECt Id, Top_Opportunity_Trigger__c from Account where Id =: op.AccountId];
            	System.debug(acc.Top_Opportunity_Trigger__c +''+ op.Amount);
                if( acc.Top_Opportunity_Trigger__c == null || acc.Top_Opportunity_Trigger__c < op.Amount){    
                    acc.Top_Opportunity_Trigger__c = op.Amount;
                    accList.add(acc);
                }  
            
            }
        }
        update accList;
    }

}