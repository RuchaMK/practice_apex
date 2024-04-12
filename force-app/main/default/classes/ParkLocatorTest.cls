@isTest
public class ParkLocatorTest {
	@isTest
    public static void testParkLocator(){
        Test.setMock(WebServiceMock.class,new ParkServiceMock());
        String[] resultExp = new String[]{'Anamudi Shola National Park', 'Anshi National Park', 'Bandipur National Parks'};
        String[] resultAct = ParkLocator.country('India');
        system.assertEquals(resultExp,resultAct,'Correct Response');
    }    
}