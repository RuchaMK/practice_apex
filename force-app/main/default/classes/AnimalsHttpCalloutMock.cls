@isTest
global class AnimalsHttpCalloutMock implements HttpCalloutMock{
    global HttpResponse respond(HttpRequest req){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type','application/json');
        res.setBody('{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}');
        res.setStatusCode(201);
        return res;
    }
    
  
}