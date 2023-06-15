/*You have a custom object called "CustomInvoice__c" with a master-detail relationship to the standard object "Account".
You want to update the "Account" custom field Last Invoice DateTime with Date  whenever a related "CustomInvoice__c" record is created or updated.*/
trigger TriggerScenario_8 on CustomInvoice__c (after insert, after update) {
    Set<Id> accountIds = new Set<Id>();
    if(Trigger.new != null){
        for(CustomInvoice__c invoice : Trigger.new){
          	 accountIds.add(invoice.Account__c);  
        }
        
        List<Account> finalUpdate = new List<Account>();
        if(accountIds.size() > 0){
            for(Account acc: [Select Id from Account where Id IN: accountIds]){
                acc.Last_Invoice_Date__c = system.now();
                finalUpdate.add(acc);
            }
        }
        
        if(!finalUpdate.isEmpty()){
            update finalUpdate;
        }
    }
}