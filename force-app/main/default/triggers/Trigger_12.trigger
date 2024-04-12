trigger Trigger_12 on Contact (before insert) {
	Set<Id> accConMap = new Set<Id>();
    List<Contact> existingConcList = new List<Contact>();
    
    for(Contact con : Trigger.new){
        if(con.Primary_Contact__c == true){
            accConMap.add(con.AccountId);
        }
    }
	existingConcList = [Select Id, AccountId  FROM Contact WHERE  AccountId in : accConMap and Primary_Contact__c  = true];
    Map<Id, Contact> newMap = new Map<Id, Contact>();
    for(Contact c : existingConcList){
        newMap.put(c.AccountId,c);
    }
    for(Contact con : Trigger.new){
        if(con.Primary_Contact__c == true){
            if(newMap.containsKey(con.AccountId)){
                con.addError('Primary Contact already present: ' + con.Id);
            }
        }
    }
}