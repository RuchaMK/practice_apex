public class ContactListDml {
    
    public static void insertContact(){ 
        try{
    List<Contact> conList = new List<Contact>{
            new Contact(LastName='Last_1',Department='Finance',Title='Finance'),
            new Contact(LastName='Last_2',Department='Finance',Title='Finance'),
            new Contact(LastName='Last_3',Department='Finance',Title='Finance'),
            new Contact(LastName='Last_4',Department='Finance',Title='Finance'),
            new Contact(LastName='Last_5',Department='HR',Title='Finance')  
    };    
        insert conList;
        }catch(DmlException e){
            system.debug('DML Exception');
            e.getMessage(); 
        }
    }
    
    public static void updateContact(List<Contact> conList){
        List<Contact> upconList = new List<Contact>();
        for(Contact con : conList){
            if(con.Department == 'Finance'){
                con.Title = 'Economy';
                upconList.add(con);
            }
        }        
        update upconList;       
    }    
    
    public static void upsertContact(){
        Contact con_1 = new Contact(LastName='Siri',Description='Tech'); 
        insert con_1;
        Contact con_2 = new Contact(LastName='Binoy',Description='Pharma');
        con_1.Description = 'Tentative';                            
        List<Contact> upsertconList = new List<Contact>{con_1,con_2}; 
        upsert upsertconList;             
        //upsert sObjectList Account.Fields.MyExternalId
        //primary key (the ID), an idLookup field, or an external ID is used to identify records
        //If the key is matched multiple times, an error is generated and the object record is neither inserted or updated.     
    }

    public static void deleteContact(){
        Contact[] con = [SELECT Id FROM Contact where LastName = 'Last_2'];
        delete con;
        //Deleted records are placed in Recycle Bin for 15 days.
    } 
    
    public static void insertAccCont(){
        Account acc = new Account();
        insert acc;
        
        Contact cont = new Contact(LastName='Bingo',AccountId = acc.Id);
        insert cont;    
        
        Contact queryCont = [SELECT Account.Name FROM Contact where LastName='Bingo'];
        queryCont.Description = 'Adding and Updating';
        queryCont.Account.Industry = 'Techno';
        queryCOnt.Account.Name = 'Name_1';
        update queryCont;
        update queryCont.Account;
    }
    
    public static void deleteContactRec(){
        Account delAcc = [SELECT Id from Account where Name='Name_1'];
        delete delAcc;
    }
    
    
}