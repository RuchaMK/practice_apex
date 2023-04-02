public class EnumExamples {    
    public enum Direction {NORTH, SOUTH, EAST, WEST}
    public static void examples(){       
        
        system.debug(Direction.NORTH);
        system.debug('NORTH ' + Direction.NORTH.name() );
        system.debug('WEST ' + Direction.WEST.name() );
//+ ' ' + Direction.WEST.values()           
    }
    
    public void CheckDirection(Direction d) {
          //datatype 
            if (d == Direction.SOUTH){
                system.debug('TRUE');
            }
        } 


}