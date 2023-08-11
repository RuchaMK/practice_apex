/*To Prevent The User From Creating Duplicate Contacts When A Contact Already Exists With The Same Email*/
trigger TriggerScenario_13 on Contact (before insert, before update) {
	List<String> newContactsEmail = new List<String>();
    List<Contact> allContactsList = new List<Contact>();
    
    for(Contact con: Trigger.new){
        if(Trigger.oldMap != null && Trigger.oldMap.get(con.Id).Email != con.Email){
            newContactsEmail.add(con.email);
        }
    }

    allContactsList = [Select id,Email from Contact where Email in: newContactsEmail and Email != null];
  
    for(Contact con: Trigger.new){
        if(allContactsList.size() > 0){
            con.email.addError('Duplicate Contact Email');
        }
    }
        
}

/*
String newContactsEmail: To save new emails being inserted from Trigger.new - can have null email values
Contact allContactsList: To get list of all contacts which exist in db with same Email 
*/