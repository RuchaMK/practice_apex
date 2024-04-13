public class QueryContact {
    public static Id getContactID(String lastName, String title) {
      try {
        Contact myContact = Database.query(
          'SELECT ID FROM Contact WHERE lastName = :lastName AND title = :title LIMIT 1'
        );
        return myContact.Id;
      } catch (Exception ex) {
        return null;
      }
    }
    public static Id getContactIDWithBinds(Map<String, Object> bindVars) {
      //do not modify any code above this line
      //implement the logic that will use bindVars to retrieve the contact's ID
      
        String query = 'SELECT ID FROM Contact WHERE lastName = :lastName AND title = :title LIMIT 1';
        List<Contact> conList = Database.queryWithBinds(query, bindVars, AccessLevel.USER_MODE);
          if(conList != null && !conList.isEmpty()){
              return conList[0].Id;
          }else{
              return null;
          }   
      
    }
  }