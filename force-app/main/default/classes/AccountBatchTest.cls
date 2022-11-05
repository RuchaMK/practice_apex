@isTest
public class AccountBatchTest {
	@testsetup
    public static void main(){
        List<Account> accList = new List<Account>();
        for(Integer i =0;i<3;i++){
        	Account acc = new Account(Name = 'acc'+i); 
            accList.add(acc);
        }
        insert accList;
         List<Contact> conList = new List<Contact>();
        for(Account acc : accList){
            Contact con =  new Contact(LastName='Con '+acc.Name, AccountId = acc.Id);
            conList.add(con);
        }
        insert conList;
        
    }
    
    @isTest
    public static void AccounBatchCheck(){    
        test.startTest();
        AccountBatch ab = new AccountBatch();
		Database.executeBatch(ab);
        test.stopTest();
        
         System.AssertEquals(3,[Select count() from Account]);
         System.AssertEquals(3,[Select count() from Contact]);
    }
    
}