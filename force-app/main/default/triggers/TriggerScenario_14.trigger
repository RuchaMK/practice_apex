/*Prevent Duplicate Contact with same Last Name and on same Account*/
trigger TriggerSceanrio_14 on Contact (before insert,before update) {
	Set<Id> accIds = new Set<Id>();
    Map<String,Contact> accIdConMap = new Map<String,Contact>();
    system.debug('1'+Trigger.new);
    for(Contact con : Trigger.new){
        if(accIds.contains(con.AccountId) && accIdConMap.containsKey(con.LastName)){
            con.addError('Duplicate AccountId and LastName');
        }
        accIds.add(con.AccountId);
        accIdConMap.put(con.LastName,con);
    }
    
    if(!accIds.isEmpty()){
        List<Contact> existingContact = [Select AccountId,LastName from Contact 
                                         where LastName!=null and AccountId!=null 
                                         and AccountId in : accIds 
                                         and LastName in : accIdConMap.keySet()];
        if(!existingContact.isEmpty()){
            for(Contact con: existingContact){
                //system.debug('10'+accIdConMap.containsKey(con.LastName) + '11' + accIdConMap.get(con.LastName).AccountId == con.AccountId);
                if(accIdConMap.containsKey(con.LastName) && accIdConMap.get(con.LastName).AccountId == con.AccountId){
                    accIdConMap.get(con.LastName).LastName.addError('DUPLICATE ERR - Contact exists with same LastName:'+con.Id);
                }
            }
        }
    }
}
/*
Account acc = new Account(Name='2acsc');
        List<Contact> conList = new List<Contact>();
        for(Integer i=0; i<3;i++){
            Contact con = new Contact(LastName = '2cfyfsofn', AccountId = acc.Id);
            conList.add(con);
        }
        insert conList; 

*/
