/* Add Account Phone in corresponding contact Phone
*/
trigger AccountUpdateTrigger on Account (after insert,after update,after delete) {
	if(true) return;
    List<account> accList = [SELECT Id, Phone,(SELECT Phone from Contacts) from Account ];
    system.debug('AccountUpdateTrigger accList' + accList);
    List<Contact> conList = new List<Contact>();
    for(Account a: accList){
        List<Contact> con = a.Contacts;
        
        for(Contact c: con){
            c.Phone = a.Phone;
             conList.add(c); 
        }
        if(con.size() > 1){
            for(Contact c:con){
                
            }
   		 }
      
    }
    
    update conList;
    
    
}