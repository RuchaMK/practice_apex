public class SpoonacularResponse {
    private static final String SPOONACULAR_API = 'https://api.spoonacular.com';
    private static final String API_KEY = '03702c12baea4a7ebb9db79f0d2268a4';
   
    @AuraEnabled
    public static String  getRandomRecipe(){
        //creating http instance
        Http http = new Http();
        
        //creating httprequest instance
        HttpRequest request = new HttpRequest();
        request.setEndPoint(SPOONACULAR_API +'/recipes/random?apiKey=' + API_KEY);
        request.setMethod('GET');
        
        //sending request
        HttpResponse response = http.send(request);
        system.debug('**Status Code: ' + response.getStatusCode());
        //check status
        if(response.getStatusCode() == 200){
            system.debug('**Response Body: ' + response.getBody());
            return response.getBody();
        }
        return '';
    }

    @AuraEnabled
    public static String  getInformation(String Id){
        Http http = new Http();
        
        HttpRequest request = new HttpRequest();
        //https://api.spoonacular.com/recipes/{id}/information
        request.setEndpoint(SPOONACULAR_API + '/recipes/' + Id + '/information?apiKey=' + API_KEY);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        system.debug('**Status Code: ' + response.getStatusCode());
        
        if(response.getStatusCode() == 200){
             system.debug('**Response Body: ' + response.getBody());
             return response.getBody();
        }
        return '';
    }

        @AuraEnabled
        public static String getRecipe(String recipeId){
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(SPOONACULAR_API+'/recipes/'+recipeId+'/information?apiKey='+API_KEY);
            request.setMethod('GET');
            
            HttpResponse response = http.send(request);
            // If the request is successful, parse the JSON response.
            if (response.getStatusCode() == 200) {
                return response.getBody();
            }
            return '';
        }

    @AuraEnabled
    public static String  getRecipeByIngredients(String ingredients){
        Http http = new Http();
        
        HttpRequest request =new Httprequest();
        //https://api.spoonacular.com/recipes/findByIngredients?ingredients=apples,+flour,+sugar&number=2
        request.setEndpoint(SPOONACULAR_API + '/recipes/findByIngredients?apiKey=' + API_KEY + '&ingredients=' +ingredients);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        system.debug('**Status Code: ' + response.getStatusCode());
        
         if(response.getStatusCode() == 200){
             system.debug('**Response Body: ' + response.getBody());
             return response.getBody();
        }   
        return '';
    }
}