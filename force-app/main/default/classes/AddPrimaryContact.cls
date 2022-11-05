/*https://trailhead.salesforce.com/content/learn/modules/asynchronous_apex/async_apex_queueable*/
public class AddPrimaryContact implements Queueable{
String abbrstate;
Contact contact;

    public AddPrimaryContact(Contact con, String state){
    this.contact = con;
    this.abbrstate = state; 
    }

    public void execute(QueueableContext context){
    List<Account> accList =  [SELECT Id ,(SELECT Id from Contacts) from Account where BillingState=:abbrstate LIMIT 200];
    //insert the Contact sObject record associated to each Account
        List<Contact> conList = new List<Contact>();
        for(Account acc : accList){
            //creating a contact for each acc and associating them
            Contact c = contact.clone();
            c.AccountId = acc.Id; //insert parent on child
            //insert c; -- never add DML in loop -- so use collections and then insert 
            conList.add(c);
        }
        
        if(conList.size()>0){           
            insert conList;
        }
    }

}