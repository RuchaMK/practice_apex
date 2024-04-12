@isTest
private class AccountManagerTest {
    static Id createAccCon(){
        Account acc = new Account(Name='Test1');
        insert acc;
        Contact con = new Contact(LastName='Con1',AccountId = acc.Id);
        insert con;
        Contact con2 = new Contact(LastName='Con2',AccountId = acc.Id);
        insert con2;
        return acc.Id;
    }
    
    @isTest 
     static void getAccountTest(){
        Id accId = createAccCon();
        RestRequest req = new RestRequest();
           req.requestURI = 'https://wise-moose-jekuwn-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Accounts/' + accId +'/contacts';
           req.httpMethod = 'GET'; 
           RestContext.request = req;
           //Test.startTest();
           AccountManager.getAccount();
          // Test.stopTest();
    }
}