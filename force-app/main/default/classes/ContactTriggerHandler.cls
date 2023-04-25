public class ContactTriggerHandler {
   
   	public static void CountContact(List<Contact> newCon, List<Contact> oldCon){
        try{
        Set<Id> accList = new Set<Id>();
        if(newCon != null){
            for(Contact con: newCon)
            accList.add(con.AccountId); //add Account Id in List
        }
        if(oldCon != null){
            for(Contact con: oldCon)
            accList.add(con.AccountId); //add Account Id in List
        }
        system.debug('Account on Contacts Size'+accList.Size());
        List<Account> accConList = [Select Id,ContactCount__c,(Select id from Contacts) From Account where Id in :accList];
        system.debug('Account to be checked Size'+accConList.Size());

        if(accConList != null){
        for(Account acc: accConList){
            acc.ContactCount__c = acc.Contacts.size();
        	}
        }
        
        if(!accConList.isEmpty()){
            update accConList;
        }
        }catch(Exception e){
            system.debug(e.getStackTraceString() + e.getLineNumber() + e.getMessage());
        }
    }
    public static void preventDuplicateContacts(List<Contact> conList, Map<Id,Contact> oldconMap){
         if(true) return;
        if(System.Label.stopTrigger =='stop'){} 
         List<String> newEmails = new  List<String>();
            List<String> existingEmails = new  List<String>();
            List<Id> existingCon = new  List<Id>();
            for(Contact con: conList){
                newEmails.add(con.Email);
            }
            
            //gives duplicate 
            List<Contact> existingContact = [SELECT Email From Contact WHERE Email IN: newEmails and Email != Null];  
            for(Contact con: existingContact){
                existingEmails.add(con.Email);
                existingCon.add(con.Id);
            }        
            
            for(Contact con : conList){
                if( existingEmails.contains(con.Email)){
                    // system.debug('$$ ' + Trigger.oldMap.get(con.Id).Email + con.Email );
                    if(con.Email == oldconMap.get(con.Id).Email){
                        //system.debug('$$ ' + Trigger.oldMap.get(con.Id).Email + con.Email );
                       continue;
                    }
                   con.Email.AddError('Duplicate Contact');                   
                }
                else
                   existingEmails.add(con.Email); //to avoid bulk insert 
            }
             
    }
    
    
   public static void preventDuplicateConOnAcc(List<Contact> conList){
    Map<String,Contact> contactMap = new Map<String,Contact>();//add error 
	Map<Id,String> accContactMap = new Map<Id,String>();//accId,duplicate_field
    List<contact> contactAccountList = new List<contact>(); //to sore db records
    
    //adding new list in above maps
    for(Contact con:conList){
        accContactMap.put(con.AccountId,con.LastName);
        contactMap.put(con.LastName,con);
    }
    
    //records in db which have same account
    contactAccountList = [SELECT Id,LastName,AccountId FROM Contact WHERE AccountId IN : accContactMap.keySet()];
        
    for(contact cons: contactAccountList){
        if(accContactMap.containsKey(cons.AccountId) && accContactMap.get(cons.AccountId) == cons.LastName  ){
            contactMap.get(cons.LastName).LastName.addError('Contact with this LastName already exists on account');
       		 }
        else{
            contactMap.put(cons.LastName, cons);
        	}
    	}
    }

}