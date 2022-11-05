Enum is used to assign numerical values to a non-numerical finite set.
Abstract data type which takes on each value defined in a finite set.
Non numerical values can be paired/corresponded to numericals values using enums. 
Further  can be used as identifiers or constants.

values(): Returns a list of type enum

public enum DIRECTIONS{NORTH,SOUTH,EAST,WEST}
List<DIRECTIONS> dirList = DIRECTIONS.values();
System.debug('values() -' + dirList);
======

valuesOf(): Returns constant of the string mentioned in parameter else throws error
public enum DIRECTIONS{NORTH,SOUTH,EAST,WEST}
System.debug('valueOf() -' + DIRECTIONS.valueOf('east'));
=======

name(): Returns a string of the enum 
public enum DIRECTIONS{NORTH,SOUTH,EAST,WEST}
System.debug('name() -' + 'SOUTH'.equals(DIRECTIONS.SOUTH.name()));
======

ordinal(): Returns the position of item in enum list as an Integer

public enum DIRECTIONS{NORTH,SOUTH,EAST,WEST}
System.debug('ordinal(): ' + ' NORTH ' + DIRECTIONS.NORTH.ordinal()
 + ' SOUTH ' + DIRECTIONS.SOUTH.ordinal()
 + ' EAST ' + DIRECTIONS.EAST.ordinal()
 + ' WEST ' + DIRECTIONS.WEST.ordinal());

 https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_enum.htm
public with sharing class enumDataType {
   

}
