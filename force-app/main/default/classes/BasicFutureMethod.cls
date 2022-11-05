public class BasicFutureMethod {
    
    //calling all future methods 
    public void callFuturemethods(){
        //no precedence, primitive types no sObject 
        Futuremethod_1();
        Futuremethod_2();
        
        List<Integer> intList = new List<Integer>{1,2};            
         	Futuremethod_3(intList);
        
    }
    
    //static, void
    @future
    public static void Futuremethod_1(){
        //BasicFutureMethod.Futuremethod_2(); show error in queue
        system.debug('In Futuremethod_1');
    }
    
    @future
    public static void Futuremethod_2(){
        system.debug('In Futuremethod_2');
    }
    
    @future
    public static void Futuremethod_3(List<Integer> inL){
        system.debug('In Futuremethod_3' + inL);
    }
    
    public static void func(){
        Futuremethod_2();
    }
    
    
}

/*OUTPUT:
BasicFutureMethod bfm = new BasicFutureMethod();
bfm.callFuturemethods();
check in logs


*/