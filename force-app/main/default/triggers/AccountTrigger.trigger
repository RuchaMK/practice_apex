/*Whenever New Account Record is created then needs to create associated Contact Record automatically.
•account name as contact lastname
•account phone as contact phone
   Object: Account
   Type: AfterInsert

Creates the number of contacts which are equal to the number which we will enter in the Number of Locations field on the Account Object.
	Create Custom field called “Number of Locations” on the Account Object (Data Type = Number)
*/

trigger AccountTrigger on Account (after insert) {
    public static boolean stopAccountTrigger;
    if(true) return;
	/* List<Contact> conList = new List<Contact>();
    
    for(Account a: Trigger.New){
        Contact con = new Contact(LastName= a.Name,AccountId = a.Id,Phone = a.Phone);
        conList.add(con);
    }
    
    insert conList; */
    if(stopAccountTrigger == false){
    Integer i,noOfContacts;
	List<Contact> conList = new List<Contact>();
    
    
    for(Account a: Trigger.new){ 
        
        if(a.Number_of_Locations__c.intValue() == null) 
            a.Number_of_Locations__c = 0;        
        else
            noOfContacts = a.Number_of_Locations__c.intValue();
                    
        for(i=1;i<=noOfContacts;i++){
            Contact con = new Contact(LastName = 'Con'+i,phone = a.Phone, AccountId = a.id);
            conList.add(con);          
        }
        
       
    }
    
     insert conList;
    }
    
}