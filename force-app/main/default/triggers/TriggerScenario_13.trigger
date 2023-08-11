/*To Prevent The User From Creating Duplicate Contacts When A Contact Already Exists With The Same Email*/
trigger TriggerScenario_13 on Contact (before insert, before update) {
	List<String> newContactsEmail = new List<String>();
    List<Contact> allContactsList = new List<Contact>();
    List<String> ExistingContactsEmail = new List<String>();
    for(Contact con: Trigger.new){
        newContactsEmail.add(con.email);
    }
    
    allContactsList = [Select id,Email from Contact where Email in: newContactsEmail];
    for(Contact con: allContactsList){
        ExistingContactsEmail.add(con.Email);
    }
    for(Contact con: Trigger.new){
        if(ExistingContactsEmail.size() > 0 && ExistingContactsEmail.contains(con.Email)){
            if(Trigger.oldMap != null && Trigger.oldMap.get(con.Id).Email == con.Email){
              continue;
            }
  				con.email.addError('Duplicate Contact Email');
        }
    }
}

/*
String newContactsEmail: To save new emails being inserted from Trigger.new
Contact allContactsList: To get list of all contacts which exist in db with same Email 
ExistingContactsEmail: consists emails from allContactsList
*/