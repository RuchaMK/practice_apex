@RestResource(urlMapping = '/customAccAPI/')
global class AccountManagement {
    
    //GET
    @HttpGet
    global static List<Account> getAccount(){
        List<Account> accList = [Select Id, Name, Rating from Account limit 10];
        return accList;
    }
    
   /* @HttpGet
    global static List<Account> getOwnerAccount(){
        Map<String,String> param = RestContext.request.params;
        String Owner = param.get('owner'); 
        List<Account> accList = [Select Id, Name, Ownership from Account where Ownership =: Owner];
        return accList;
    } 
    
    @HttpGet
    global static AccWrapper getAccount(){
        Map<String,String> param = RestContext.request.params;
        String Owner = param.get('owner');
        List<Account> accList = [Select Id, Name, Ownership from Account where Ownership =: Owner];
         List<Contact> conList = [Select Id, LastName from Contact where AccountId in:  accList];
         List<Opportunity> oppList = [Select Id, Amount from Opportunity where AccountId in:  accList];
		AccWrapper accWrapper = new AccWrapper();
        accWrapper.accList = accList;
        accWrapper.conList = conList;
        accWrapper.oppList = oppList;
        return accWrapper;
    }
    
    //POST
    /*@httpPost
    global static String createAccount(String name,String indus){
        Account acc = new Account(Name = name, Industry = indus);
        try{
            insert acc;
            return 'Account Created Successfully!!' + acc.Id;
        }catch(Exception ex){
            system.debug(ex.getMessage());
            return 'Failure in Account Creation';
        }
    }*/
    
    @HttpPost
    global static String createAccount(AccWrapper accWrapper){
        Account acc = accWrapper.accRecord;
        Contact con = accWrapper.conRecord;
       
        try{
            insert acc;
            con.AccountId = acc.Id;
            insert con;
            return 'Account ' + acc.Id + ' and Contact ' + con.Id + ' Created Successfully!!';
        }catch(Exception ex){
            system.debug(ex.getMessage());
            return 'Failure in Account or Contact Creation';
        }
    }
	
	@HttpDelete
    global static String delAccount(){
        Map<String,String> param = RestContext.request.params;
        String accId = param.get('accid');
        List<Account> accList = [SELECT Id from Account where Id =: accId];
        if(!accList.isEmpty()){
            try{
                delete accList;
                return 'Account Deleted';
            }catch(Exception ex){
                system.debug(ex.getMessage());
                return 'Operation Failed';
            }
            
        }
        else{
            return 'No records Found';
        }
    }
}