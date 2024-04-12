@isTest
global class verifyMockCallout implements HttpCalloutMock{
    global HttpResponse respond(HttpRequest req){
        HttpResponse mockRes = new HttpResponse();
        mockRes.setHeader('Content-Type','application/json');
        mockRes.setBody('{ "status": "success", "phone": "+919807658957", "phone_valid": true, "phone_type": "mobile", "phone_region": "India", "country": "India", "country_code": "IN", "country_prefix": "91", "international_number": "+91 98076 58957", "local_number": "098076 58957", "e164": "+919807658957", "carrier": "Aircel" }');
        mockRes.setStatusCode(200);
        return mockRes;
    }
}