global class AnimalLocatorMock implements HttpCalloutMock{
    global HttpResponse respond(HttpRequest req){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type','application/json');
        res.setBody('{"animal": {"id": 1,"name": "chicken", "eats": "chicken food", "says": "cluck cluck"}}');
        res.setStatusCode(200);
        return res;
    }
    
}