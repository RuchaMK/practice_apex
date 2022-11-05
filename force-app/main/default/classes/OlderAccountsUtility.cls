public class OlderAccountsUtility {
    public static void updateOlderAccounts(){
        Account[] accts = [SELECT Description FROM Account ORDER BY CreatedDate ASC LIMIT 5];
        //arrays and list are same in Apex
        
        for(Account a : accts){
            a.Description = 'Heritage Account';
        }
        update accts;
    }
    
    public static void listBasics(){
      String[] colors = new List<String>();
      //List<String> shapes = new List<String>(); 
      List<String> shapes = new List<String> {'circle','triangle','square'};
      colors.add('red');
      colors.add('blue');
      colors.add('green');
        
        for(Integer i=0;i<3;i++){
        system.debug('Color '+ colors[i] + ' Shape ' + shapes[i]);
        }
     
    }
    
}
/*
 OlderAccountsUtility.updateOlderAccounts();
https://developer.salesforce.com/docs/atlas.en-us.224.0.apexcode.meta/apexcode/langCon_apex_collections.htm
*/