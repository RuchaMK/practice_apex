/*1. Whenever a case is created with origin as ‘Phone’ then 
set status as ‘New’ and Priority as ‘High’.*/

trigger CaseTrigger on Case (before insert) {
    if(true){return;}
   for(Case c: Trigger.new){
       
       if(c.Origin == 'Phone'){
           c.Status = 'New';
           c.Priority = 'High';
       }

   }


}