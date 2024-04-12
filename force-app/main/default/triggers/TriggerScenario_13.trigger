/*Update Parent Whenever a contacts description is updated then its parent account's description should get updated by related contact desc.*/
trigger TriggerScenario_13 on Contact (after update) {
	Map<Id,Contact> conAccMap = new Map<Id,Contact>();
    List<Account> accList = new List<Account>();
    for(Contact con: Trigger.new){
        if(Trigger.oldMap != null && Trigger.oldMap.get(con.Id).description != con.Description){
        conAccMap.put(con.AccountId,con);
        }
    }
    
    if(!conAccMap.isEmpty()){
        for(Account acc : [Select Description from Account where Id in:conAccMap.keySet()]){
            acc.Description = conAccMap.get(acc.Id).Phone;
            accList.add(acc);
        }
    }
    
    if(!accList.isEmpty()){
        update accList;
    }
}
/*
String newContactsEmail: To save new emails being inserted from Trigger.new - can have null email values
String existingContactsEmail: consists emails from allContactsList
Scenario:
Fail-
changed email exists

Success-
null email
new email
update but email not changed
rec1 mail1 and delete, rec2 mail1 rec1 undelete 

List<Contact> conList = new List<Contact>();
for(Integer i =0 ; i<3;i++){
    conList.add(new Contact(LastName='test',Email='Test1@t.com'));
}
conList.add(new Contact(LastName='test',Email='Test10@t.com'));
insert conList;
*/