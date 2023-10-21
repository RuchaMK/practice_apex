/*To Prevent The User From Creating Duplicate Contacts When A Contact Already Exists With The Same Email
Prevent Duplicate contacts based on Email
*/
trigger TriggerScenario_13 on Contact (before insert, before update, after undelete) {
    //field to check -<Email,Contact>-<check,throwerror>
	Map<String,Contact> newContacts = new Map<String,Contact>();
    List<Contact> existingContacts = new List<Contact>();
    if(true)return;
    for(Contact con:Trigger.new){
        if(newContacts.containsKey(con.Email)){
            con.addError('Duplicate Email');
        }
        newContacts.put(con.Email,con);
    }
  
    if(!newContacts.isEmpty()){
        system.debug(Trigger.new);
        existingContacts = [Select Id, Email from Contact where Email!=null and Email in: newContacts.keySet() and Id not in: Trigger.new];
       
        if(!existingContacts.isEmpty()){ //we got duplicates
            
            for(Contact con: existingContacts){
                 system.debug(con.Id);
                if(newContacts.containsKey(con.Email)){
                    newContacts.get(con.Email).Email.addError('Duplicate EMAIL, exists on :' + con.Id);
                }
                
            }
        }
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