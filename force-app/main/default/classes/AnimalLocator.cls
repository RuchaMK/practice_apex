public class AnimalLocator {
    public static String getAnimalNameById(Integer Id){
        String name = '';
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        String endpoint = ' https://th-apex-http-callout.herokuapp.com/animals/'+Id;
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        if(res.getStatusCode() == 200){
            system.debug(res);
            Map<String,Object> result = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
         	system.debug(result);   
			Map<String,Object> animal =(Map<String,Object>)result.get('animal');
            //system.debug(animal.get('name'));
            name = (String)animal.get('name');
       
        }
        return name;
    }

}