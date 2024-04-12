@isTest
public class verifyAccountPhoneNumber_Test {
    @isTest
	public static void validatePhone_Test(){
        //Test.setMock(HttpCalloutMock.class, new YourHttpCalloutMockImpl());
        Test.setMock(HttpCalloutMock.class, new verifyMockCallout());
        validateAccoutPhoneNumber.phoneWrapper pw = validateAccoutPhoneNumber.validatePhone('90807876543');
        System.assertEquals(pw.phone_valid,true);
    }
}