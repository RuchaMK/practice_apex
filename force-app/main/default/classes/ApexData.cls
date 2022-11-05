public with sharing class ApexData {
    public ApexData() {

    }
    @AuraEnabled(cacheable = true)
    public static List<Account> getAccounts(){
        return [Select Name,Phone,Type from Account  order by Name Desc limit 20];
        
    }

    @AuraEnabled(cacheable = true)
    public static List<Contact> getContacts(String accountId){
       return [Select FirstName,LastName,Name,Email From Contact where Account.Id =: accountId];
    }

    @AuraEnabled
   public static String imgetMessage(string body){
    return (body+ ' ' + Math.random()*10 );
   }
   

}