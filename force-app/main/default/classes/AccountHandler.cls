//Trailhead - Manipulate Records with DML
public class AccountHandler {
    public static Account insertNewAccount(String name){
        if(name == ''){
            return null;
        }              
        Account acc = new Account(Name=name);
        insert acc;
        return acc;        
    }

}