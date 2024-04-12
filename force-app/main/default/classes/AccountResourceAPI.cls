@RestResource(urlMapping='/Account/*')
global class AccountResourceAPI {
	public class AccWrapper{
        public String name{get;set;}
        public String phone{get;set;}
        //public String type{get;set;}
    }
    @HttpGet
    global static Account getRecord(){
        RestRequest request = RestContext.request;
        system.debug('Server1:'+request);
        String accId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
         system.debug('accId:'+accId);
        Account acc = [Select Id,Name,Phone from Account where Id =: accId];
        return acc;
    }
    
    @HttpPost
    global static Id createRecord(String name, String phone){
        RestRequest request = RestContext.request;
        system.debug('Debug:'+request);
        Account acc = new Account(Name = name, Phone = phone);
        insert acc;
        return acc.Id;
    }
    @HttpPut
    global static Id upsertRecord(String name, String phone){
        System.debug('upsertRecord PUT Method');
        RestRequest request = RestContext.request;
        system.debug('Server1:'+request);
        Account acc = new Account(Name = name, Phone = phone);
        upsert acc;
        return acc.Id;
    }
    @HttpPatch
    global static Id updateRecord(){
        RestRequest req = RestContext.request;
		String accId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        system.debug('DEB1:'+req.requestbody);
        Map<String,Object> reqMap = (Map<String,Object>)JSON.deserializeUntyped(req.requestbody.toString());//blob to string
        Account acc = [Select id from Account where Id =: accId];
        for(String fieldName : reqMap.KeySet()){
            acc.put(fieldName,reqMap.get(fieldName));
        }
        update acc;
        //AccWrapper wrap = (AccWrapper)JSON.deserialize(req.requestBody.toString(),AccWrapper.class);
        return accId;
    }
    @HttpDelete
    global static void getAccount(){
        RestRequest req = RestContext.request;
        String accId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account acc = [Select Id,Name from Account where Id =: accId];        
        delete acc;
    }
  
}