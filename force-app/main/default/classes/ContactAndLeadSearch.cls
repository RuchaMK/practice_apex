public class ContactAndLeadSearch {
    public static List<List<sObject>>  searchContactsAndLeads(String str){
        List<List<sObject>> soslSearch = [FIND :str IN ALL FIELDS returning Contact(FirstName,LastName),Lead(FirstName,LastName)];
       //FIND {Wingo} IN ALL FIELDS RETURNING Account(Name), Contact(FirstName,LastName,Department)
        return soslSearch;
    }

}