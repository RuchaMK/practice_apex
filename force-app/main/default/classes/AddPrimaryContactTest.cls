@isTest
public class AddPrimaryContactTest {

    @testSetup
    public static void init(){
        List<Account> accList = new List<Account>();
        for(Integer i = 0;i<50;i++){
       	 accList.add(new Account(Name='NYAcc'+i,BillingState='NY')); 
       }
        for(Integer i = 0;i<50;i++){
       	 accList.add(new Account(Name='CAAcc'+i,BillingState='CA')); 
       }
        insert accList;
    }
    
    @isTest
    public static void testQueueable(){
        Contact con = new Contact(LastName='associateCon');
        insert con;
        AddPrimaryContact apc = new AddPrimaryContact(con,'NY');
        Test.startTest();
        System.enqueueJob(apc);
        Test.stopTest();
        system.assertEquals(50, [SELECT count() from Contact where AccountId in (SELECT id from Account where BillingState='NY')]);
    }
    
}