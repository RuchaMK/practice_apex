//Unrelated Objects - While creating or updating Lead check whether Email is already there in existing contact , 
//if it is there then throw an error.
trigger TriggerScenario_4 on Lead (before insert, before update){
    if(true) return;
   List<String> emailToContactId = new List<String>();
        
    for(Contact contact : [SELECT Id, Email FROM Contact]) {
        emailToContactId.add(contact.Email);
    }
    
    for(Lead lead : Trigger.new) {
        if (emailToContactId.contains(lead.Email) && lead.Email != null && lead.Email != Trigger.oldMap.get(lead.Id).Email) {
            lead.addError('Email already exists in contacts');
        }
    }
   
    
}