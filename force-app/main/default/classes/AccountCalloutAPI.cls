public class AccountCalloutAPI {
    public static Http http = new Http();
    public static HttpRequest req;
    public static HttpResponse res;
    
    
	public class AccWrapper{
        public String name{get;set;}
        public String phone{get;set;}
        //public String type{get;set;}
    }
    
    //get
    public static void getAccount(String accId){
        req = new HttpRequest();
        req.setHeader('Content-Type','application/json;charset=UTF-8');
        req.setEndpoint('callout:Salesforce_Org/services/apexrest/Account/'+accId);
        req.setMethod('GET');
        res = http.send(req);  
        if(res.getStatusCode() == 200){
        Map<String,Object> result = ( Map<String,Object>)JSON.deserializeUntyped(res.getBody());
        //Map<String,Object> innerResult = (Map<String,Object>)result.get('attributes');
        //system.debug('Debug0'+innerResult.get('url'));
             system.debug('Debug1'+ result.get('Id'));
        }
    }
    //post
     public static void createAccount(String accName, String accPhone){
        req = new HttpRequest();
        req.setHeader('Content-Type','application/json;charset=UTF-8');
        req.setEndpoint('callout:Salesforce_Org/services/apexrest/Account/');
        req.setMethod('POST');
        AccWrapper accWrapper = new AccWrapper();
        accWrapper.name = accName;//'APIPUT';
        accWrapper.phone = accPhone;//'0989743902523';
        system.debug('Before Serialize'+ accWrapper);
        system.debug('After Serialize'+ JSON.serialize(accWrapper));
        req.setBody(JSON.serialize(accWrapper));
        //req.setBody(JSON.serialize(new Map<String, String>{ 'name' => accName, 'phone' => accPhone }));
        res = http.send(req); 
        if(res.getStatusCode() == 200){
 			system.debug('Account Id: '+res.getBody());             
        }
    }
    //put
     public static void upsertAccount(String accName, String accPhone){
        req = new HttpRequest();
        req.setHeader('Content-Type','application/json;charset=UTF-8');
        req.setEndpoint('callout:Salesforce_Org/services/apexrest/Account/');
        req.setMethod('PUT');
        AccWrapper accWrapper = new AccWrapper();
        accWrapper.name = accName;//'APIPUT';
        accWrapper.phone = accPhone;//'0989743902523';
        //accWrapper.type = type;
        system.debug('Before Serialize'+ accWrapper);
        system.debug('After Serialize'+ JSON.serialize(accWrapper));
        req.setBody(JSON.serialize(accWrapper));
        //req.setBody(JSON.serialize(new Map<String, String>{ 'name' => accName, 'phone' => accPhone }));
        res = http.send(req); 
        if(res.getStatusCode() == 200){
 			system.debug('Account Id: '+res.getBody());             
        }
         //send id and check on server end
    }
     //patch
     public static void updateAccount(String accId, String accName, String accPhone){
        req = new HttpRequest();
        req.setHeader('Content-Type','application/json;charset=UTF-8');
        req.setEndpoint('callout:Salesforce_Org/services/apexrest/Account/'+accId);
        req.setMethod('PATCH');
        /*AccWrapper accWrapper = new AccWrapper();
        accWrapper.name = accName;//'APIPUT';
        accWrapper.phone = accPhone;//'0989743902523';
        system.debug('Before Serialize'+ accWrapper);
        system.debug('After Serialize'+ JSON.serialize(accWrapper));
        req.setBody(JSON.serialize(accWrapper));*/   
       
        req.setBody(JSON.serialize(new Map<String, String>{'name'=> accName, 'phone'=> accPhone }));
        res = http.send(req); 
        if(res.getStatusCode() == 200){
 			system.debug('Account Id: '+res.getBody());             
        }
    }
    
    //delete
     public static void deleteAccount(String accId){
        req = new HttpRequest();
        req.setHeader('Content-Type','application/json;charset=UTF-8');
        req.setEndpoint('callout:Salesforce_Org/services/apexrest/Account/'+accId);
        req.setMethod('DELETE');
        res = http.send(req); 
        if(res.getStatusCode() == 200){
 			system.debug('Deleted');             
        }
    }
/*
//get - AccountCalloutAPI.getAccount('0015g00001TbTL2AAN');
//post - AccountCalloutAPI.createAccount('APIPUT','00000');
//put - AccountCalloutAPI.upsertAccount('APIPUT','00000','Prospect');
//patch - AccountCalloutAPI.updateAccount('0015g00001VyJndAAF','bnjbjkbk','11111');
//delete - AccountCalloutAPI.deleteAccount('0015g00001VyJxTAAV');
*/    
}