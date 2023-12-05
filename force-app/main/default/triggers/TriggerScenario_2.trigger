// Whenever phone is modified on account object then update contact record with phone field
trigger TriggerScenario_2 on Account (after update){
    	if(true) return;
        List<Contact> conList = new List<Contact>();
        Map<Id,Account> updatedAccMap = new Map<Id,Account>();
   
    for(Account acc : Trigger.New){   
		//only phone field is updated
        if(acc.Phone != null && Trigger.oldMap != null && acc.Phone != Trigger.oldMap.get(acc.Id).Phone){
            updatedAccMap.put(acc.Id,acc);
    	}
		
        if(updatedAccMap.size() > 0){
            for(Contact con: [Select id,Phone,AccountId from Contact where AccountId in : updatedAccMap.keySet()]){
                con.Phone = updatedAccMap.get(con.AccountId).Phone;
                conList.add(con);
            }
        }
        if(conList.size()>0){
            update conList;
        }
}
}
/*
Make a "map" of the obj "which is modified"
"Query" the object "that needs to be modified"
Map<changedObject>
[toChange]

1. Loop over new list
2. Make a map of what is updated - updatedIdList
3. Loop over what needs to be updated
4. Query related records n update
*/
