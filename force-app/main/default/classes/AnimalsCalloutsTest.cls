@isTest
private class AnimalsCalloutsTest {
    @isTest static void testGetCallout(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type','application/json;charset=UTF=8');
        Test.setMock(HttpCalloutMock.class,mock);
        HttpResponse resResult = AnimalsCallouts.makeGetCallout();
        System.assertNotEquals(null,resResult,'Callout return null reponse');
        System.assertEquals(200,resResult.getStatusCode(),'The status code is not 200');
        System.assertEquals('application/json;charset=UTF=8',resResult.getHeader('Content-Type'),'The content type value is not expected');
        
        Map<String,Object> result = (Map<String,Object>)JSON.deserializeUntyped(resResult.getBody());
        List<Object> animals = (List<Object>) result.get('animals');
        System.assertEquals(3,animals.size(),'The array should have only 3 elements');
    }
    
      @isTest
    static void testPostCallout(){
        Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutMock());
        HttpResponse res = AnimalsCallouts.makePostCallout();
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType=='application/json');
        String actualValue = res.getBody();
        System.debug(res.getBody());
        String expectedValue = '{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}';
        System.assertEquals(expectedValue,actualValue);    
        System.assertEquals(201,res.getStatusCode());    
    }
}