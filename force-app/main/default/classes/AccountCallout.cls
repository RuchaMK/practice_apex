public class AccountCallout {
	
    public static void getAccounts(){
		//creating http instance
		Http http = new Http();
        
        //creating httprequest instance
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:AccessAccc/services/apexrest/customAccAPI/');
        request.setMethod('GET');
        
		//sending request
		HttpResponse response = http.send(request); 
        system.debug('**Response Body ' + response.getBody());
        if(response.getStatusCode() == 200){
           /* List<Object> results = (List<Object>)JSON.deserializeUntyped(response.getBody());
            for(Object obj: results){
                //System.debug('Obj: '+ obj);
                Map<String,Object> accRecord = (Map<String,Object>) obj;
                system.debug(accRecord.get('Name'));
			}*/
            List<AccountReponseHandler> accRep = AccountReponseHandler.parse(response.getBody());
            for(AccountReponseHandler acc : accRep){
                system.debug(acc);
            }
            
        }else{
            System.debug('Error' + response.getBody());
        }
    }
}