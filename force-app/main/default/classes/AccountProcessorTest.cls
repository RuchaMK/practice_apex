@isTest
public class AccountProcessorTest {
    @testSetup
    public static void initData(){
        Account acc_1 = new Account(Name='acc_1');       
        List<Contact> conList = new List<Contact>();
        for(integer i=0;i<3;i++){
            conList.add(new Contact(AccountId = acc_1.Id,LastName='myRecord'));
            }
        insert acc_1;
        insert conList;        
    }
    
    @isTest
    public static void countContacts(){
        List<Account> acc = [select Id from Account];
        List<Id> IdList = new List<Id>{acc[0].Id};
        Test.startTest();
        AccountProcessor.countContacts(IdList);
        Test.stopTest();
    }
}