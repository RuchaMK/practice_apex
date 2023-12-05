/*Prevent Duplicates on Contact based on Phone number and LastName*/
//==================v2====================
trigger TriggerScenario_18 on Contact (before insert,before update) {
    //fields to check
    Map<String,Contact> phoneContactMap = new Map<String,Contact>();
    Map<String,Contact> emailContactMap = new Map<String,Contact>();
    List<Contact> existingContacts = new List<Contact>();
    system.debug(Trigger.new);
      for(Contact con : Trigger.new){
          system.debug('1'+con.Id);
          phoneContactMap.put(con.Phone,con);
          emailContactMap.put(con.Email,con);
      }
    
      if(!phoneContactMap.isEmpty() && !emailContactMap.isEmpty()){
          existingContacts = [Select Id,Email,Phone from Contact where 
                              Email!=null and Phone!=null
                              and Id not in : Trigger.new
                              and (Email in : emailContactMap.keySet()
                              or Phone in : phoneContactMap.keySet())
                              ];
          
          if(!existingContacts.isEmpty()){
              for(Contact con : existingContacts){// 12 r
               
                  if(phoneContactMap.containsKey(con.Phone) && emailContactMap.containsKey(con.Email)){
                      phoneContactMap.get(con.Phone).addError('Duplicate Email and Phone, exists on: '+ con.Id);
                  }else{
                      if(emailContactMap.containsKey(con.Email)){
                          emailContactMap.get(con.Email).Email.addError('Duplicate Email, exists on: '+ con.Id);
                      }if(phoneContactMap.containsKey(con.Phone)){
                          phoneContactMap.get(con.Phone).Phone.addError('Duplicate Phone, exists on: '+ con.Id);
                      }
                  } 
                 phoneContactMap.put(con.Phone,con);
                 emailContactMap.put(con.Email,con); 
              
              }
          }
      }
  }
  
  /*
  List<Contact> conList = new List<Contact>();
  for(Integer i =0 ; i<3;i++){
      conList.add(new Contact(LastName='tesft',Email='tefst@test.com',Phone='162324'));
  }
  
  insert conList;
  
  List<Contact> conList = new List<Contact>();
  //for(Integer i =0 ; i<3;i++){
      conList.add(new Contact(LastName='t9esft',Email='9tefst@test.com',Phone='9162324'));
  //}
  
  insert conList;
  */

/*//==================v1==================
trigger myTrig_16 on Contact(before insert,before update){
	Map<String,Contact> conList = new Map<String,Contact>();
	Set<String> phoneSetFetch = new Set<String>();
	List<Contact> existingConList = new List<Contact>();
	
	for(Contact con : Trigger.new){
		if(conList.contains(con.Phone) && conList.contains(con.LastName)){
			con.addError('Bulk Operation same phone number and LastName detected');
		}else{
			conList.put(con.LastName,con);
			phoneSetFetch.add(con.Phone);
		}
	}
	
	if(!phoneSetFetch.isEmpty){
		existingConList = [Select Id from Contact where con.LastName != null and con.Phone != null
						   and con.LastName in : conList.keySet() and con.Phone in : phoneSetFetch];
	}
	
	if(!existingConList.isEmpty){
		for(Contact con : existingConList){
			if(conList.containsKey(con.LastName) && conList.get(con.LastName).Phone.equals(con.Phone)){
				conList.get(con.LastName).addError('Duplicate Phone number and Last name');
			}
		}
	}
}


*/
