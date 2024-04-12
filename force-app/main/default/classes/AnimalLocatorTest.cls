@isTest
public class AnimalLocatorTest {
	/*@isTest
    static void testMockCallout_1(){
        Test.setMock(HttpCalloutMock.class,new AnimalLocatorMock());
        String res = AnimalLocator.getAnimalNameById(1);
        System.assertEquals('chicken',res,'Wrong name');
        
    }*/
    @isTest
    static void testMockCallout_2(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResourceById');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type','application/json');
        Test.setMock(HttpCalloutMock.class,mock);
        String res = AnimalLocator.getAnimalNameById(1);
        System.assertEquals('chicken',res,'Wrong name');
        
    }
}