/*Prevent Duplicate Contact with same Last Name and on same Account*/
trigger TriggerScenario_14 on Contact(before insert, before update, after undelete){
    //map con id and acc id 
	//map existingconList
	//iterate
	Map<Id,String> toCompare =  new Map<Id,String>();
	Map<String,contact> conList = new Map<String,contact>();
    if(Trigger.new != null){
        for(Contact con: Trigger.new){
            toCompare.put(con.AccountId, con.LastName);
            conList.put(con.LastName,con);
        }
    }
    
	List<Contact> existingContact = [Select LastName, AccountId from Contact where AccountId in: toCompare.keyset()];
        
    for(Contact con: existingContact){
	system.debug('To Compare: '+toCompare);
system.debug('existingContact: '+existingContact);
system.debug('2'+toCompare.containsKey(con.AccountId));
system.debug('3'+toCompare.get(con.AccountId) + '=='+con.LastName);
        if(toCompare.containsKey(con.AccountId) && toCompare.get(con.AccountId).equals(con.LastName)){
            conList.get(con.AccountId).LastName.addError('Contact with this LastName already exists on Account: '+ con.AccountId);
        }
        else{
            toCompare.put(con.AccountId,con.LastName);//for bulk
        }

    }
    
}
/*
toCompare: storing values that need comparison
existingContact: To find all records in existing db which have same comparable parameters
conList: To show error on LastName field of contact
Scenarios:
Pass:
Both Diff: 1 1
Same LastName diff AccountId: 0 1
Diff LastName same AccountId: 1 0

Fail:
Same Last Name and same Account Id: 0 0 

List<Contact> conList = new List<Contact>();
for(Integer i =0 ; i<3;i++){
    conList.add(new Contact(LastName='test',Email='Test1@t.com',AccountId='0015j00000nA80KAAS'));
}
conList.add(new Contact(LastName='test',Email='Test10@t.com'));
insert conList;


*/