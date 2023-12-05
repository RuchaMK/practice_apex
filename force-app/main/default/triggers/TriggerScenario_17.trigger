/* Prevent Multiple Primary Contact on Parent Account
One Primary Contact per Account*/
/*Prevent Multiple Primary Contact on Parent Account
One Primary Contact per Account*/
trigger checkTrigger on Contact(before insert, before update, after undelete){
	//if(true) return;
    Map<Id,Contact> accConMap = new Map<Id,Contact>();
	List<Contact> existingConList = new List<Contact>();
	
	for(Contact con : Trigger.new){
         if(con.Primary_Contact__c == true){
		accConMap.put(con.AccountId,con);
             }
	}
	
	if(!accConMap.isEmpty()){
		existingConList = [Select Id, AccountId  FROM Contact WHERE  AccountId in : accConMap.keySet() and AccountId != null and Primary_Contact__c = true];
	}
	system.debug('$$'+existingConList+'%%'+accConMap);
	if(!existingConList.isEmpty()){
            for(Contact con : existingConList){
                if(accConMap.containsKey(con.AccountId)){
                     accConMap.get(con.AccountId).AccountId.addError('Primary Contact already present: ' + con.Id);
                }                              
            }        
	}
}

/*================================================================v2=================================================================
trigger TriggerScenario_17 on Contact (before insert, after undelete,before update) {
    Set<Id> accountIdsWithPrimaryContact = new Set<Id>();
     Map<Id, Contact> accountIdToPrimaryContactMap = new Map<Id, Contact>();
 
     // Gather all Account IDs associated with primary contacts in Trigger.new
     for (Contact newContact : Trigger.new) {
         if (newContact.Primary_Contact__c == true) {
             accountIdsWithPrimaryContact.add(newContact.AccountId);
         }
     }
 
     // Query for existing primary contacts for these Account IDs
     for (Contact contact : [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIdsWithPrimaryContact AND Primary_Contact__c = true]) {
         accountIdToPrimaryContactMap.put(contact.AccountId, contact);
     }
 
     for (Contact newContact : Trigger.new) {
         if (newContact.Primary_Contact__c == true) {
             // If the account already has a primary contact, throw an error
             if (accountIdToPrimaryContactMap.containsKey(newContact.AccountId)) {
                 Contact existingPrimaryContact = accountIdToPrimaryContactMap.get(newContact.AccountId);
                 newContact.addError('Account already has a primary contact: ' + existingPrimaryContact.Name);
             } else {
                 // Update the accountIdToPrimaryContactMap
                 accountIdToPrimaryContactMap.put(newContact.AccountId, newContact);
             }
         }
     }
 } 
*/
//===========================================V1===============================================
/*Enforce single primary contact on Account, uncheck the checkbox for multiple contact
**Checkbox Field on Contact : Primary_Contact__c, only 1 contact on same Account should have primary contact checked*/
/*trigger TriggerScenario_17 on Contact (before insert, after undelete,before update) {
	Map<Id,Contact> AccountIds = new Map<Id,Contact>();
    
    if(!Trigger.new.isEmpty()){
        for(Contact con: Trigger.new){
            if(con.Primary_Contact__c == true){
                AccountIds.put(con.AccountId,con);
            }
        }
        if(!AccountIds.isEmpty()){
            List<Account> accConList = [Select Id, Name, (Select Name,Primary_Contact__c from Contacts where Primary_Contact__c = true) from Account where Id in:AccountIds.keySet()];
        
        if(!accConList.isEmpty()){
            for(Account acc: accConlist){
                system.debug('Size '+ acc.Contacts.size());
                if(acc.Contacts.size()>=1){
                    AccountIds.get(acc.Id).addError('Primary Contact already present on Account Name'+ acc.Name +  ' Contact Name : ' +acc.Contacts[0].Name);                                         
                }else{
                    acc.Contacts.add(AccountIds.get(acc.Id));//to tackle bulk insert
                }
            }
        }
   }
    }
}*/
