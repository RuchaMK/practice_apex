public with sharing class ApexLwcBasic {

     @AuraEnabled(cacheable=true)
   public static List<Account> getAccounts() {
    return [SELECT Id,Name,Industry,Rating,WebSite,AnnualRevenue from Account order by Name DESC limit 25 ];
    }

    //imperative 
    @AuraEnabled
    public static List<Contact> getContacts(){
      return [SELECT Id,Name from Contact Limit 10];
    }


}