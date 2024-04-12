public with sharing class viewExtImage {
    
    @AuraEnabled
    public static string getExtImage() {
        try {
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://api.thecatapi.com/v1/images/search');
            req.setMethod('GET');
            HttpResponse res = http.send(req);
            return res.getBody();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        
    }
}