public class validatePhoneNumbers {
    
    public static String validateNum(String objName, String phoneNumField, String phoneStatusField, String recordId){
        //http://apilayer.net/api/validate?access_key=123&number=1234&country_code=&format=1
        String endpointURL = System.Label.numverifyUrl + System.Label.numVerifyKey;
        //http://apilayer.net/api/validate?access_key=123
        
        String soqlquery = 'Select Id,'+phoneNumField+','+phoneStatusField+' from '+objName + ' where Id in : ' + recordId;
        system.debug('Query: ' + soqlquery);
        
        sObject sobj = Database.query(soqlquery);
        String phoneNum = (String)phoneNumField;
        
        //final endpoint
        endpointURL += '&number='+phoneNum+'&country_code=&format=1';
        
        //http request
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        HttpResponse res = new HttpResponse();
        
        req.setHeader('Content-Type','application/json');
        req.setEndpoint(endpointURL);
        req.setMethod('GET');
        try{
            res = http.send(req);
            if(res.getStatusCode() == 200){
                String resBody = res.getBody();
                sobj.put(phoneStatusField,resBody);
                update sobj;
            }else{
                String resBody = res.getBody();
                sobj.put(phoneStatusField,resBody);
                update sobj;
            }
        }catch(Exception ex){
            system.debug('Exception:'+ex.getMessage());
        }
       
        
        return null;
    }

}