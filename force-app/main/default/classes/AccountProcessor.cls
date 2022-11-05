//Trailhead - Asynchronous Apex - Use Future Methods
public class AccountProcessor {
    @future
    public static void countContacts(List<Id> accId){
        List<Account> accList = [SELECT Id, (SELECT Id FROM Contacts),Number_Of_Contacts__c FROM Account];
        for(Account a : accList){
            a.Number_Of_Contacts__c = a.Contacts.size();
            //system.debug(' Id '+a.Id +' %% '+a.Contacts.size());
        }
 
    }
}