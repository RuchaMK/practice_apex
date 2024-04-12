@isTest
public class verifyAccountPhoneNumber_Test1 {
    @isTest
    public static void validatePhone_Test1(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setHeader('Content-Type','application/json');
        mock.setStaticResource('verifyPhoneStaticResource');
        mock.setStatusCode(200);
        Test.setMock(HttpCalloutMock.class, mock);
        validateAccoutPhoneNumber.phoneWrapper pw = validateAccoutPhoneNumber.validatePhone('90807876543');
        System.assertEquals(pw.phone_valid,true);
    }
}