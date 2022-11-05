public class ContactListDatabase {
    public static void insertDatabase(){
    List<Contact> conList = new List<Contact>{
                new Contact(LastName='Last_1',Department='Finance',Title='Finance'),
                new Contact(LastName='Last_2',Department='Finance',Title='Finance'),
                new Contact() };
    Database.SaveResult[] srList = Database.insert(conList);
    
    for(Database.SaveResult sr : srList){
        if(sr.isSuccess()){
            system.debug('Successfully inserted '+ sr.getId());
        }
        else{
            for(Database.Error err : sr.getErrors()){
                system.debug('Insert Failed status code: '+err.getStatusCode()+' Message ' + err.getMessage() + ' Fields affected ' + err.getFields());
            }
        }
     }
    }
}