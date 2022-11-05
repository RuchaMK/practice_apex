//Trailhead Get Started with Apex
public class StringArrayTest {
    
    public static List<String> generateStringArray(Integer num){
        List<String> finalList = new List<String>();
        for(Integer i=0;i<num;i++){
            finalList.add('Test '+i);
            System.debug(finalList[i]);
        }
        
        return finalList;
    }
    
}
/*
System.debug(StringArrayTest.generateStringArray(3));
*/