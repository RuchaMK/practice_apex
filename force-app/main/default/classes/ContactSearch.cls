public class ContactSearch {
    public static List<Contact> searchForContacts(String str1, String str2){
        List<Contact> con = [SELECT Id, Name from Contact where LastName =: str1 AND MailingPostalCode =: str2];
        
        return con;
    }

}