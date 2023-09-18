@isTest
public class TriggerTestClass {
	@TestSetup
    static void initData(){
        Account acc1 = new Account(Name='acc1');
        insert acc1;
        List<Contact> conList = new List<Contact>();
        for(Integer i=0; i<10;i++){
            Contact con = new Contact(LastName = 'con' + i, AccountId=acc1.Id);
            conList.add(con);
        }
        insert conList;       
    }
    
    @isTest
    static void validateTriggerScenario_17Bulk(){
        List<Contact> updateConList = new List<Contact>();
        List<Contact> conList = [Select Id from Contact limit 5];
        for(Contact con: conList){
            con.Primary_Contact__c = true;
            updateConList.add(con);
        }
        insert updateConList;
    }
}