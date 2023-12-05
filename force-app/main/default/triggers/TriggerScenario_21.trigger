/*
When Record is added in Event Registration Object Booking Field in Event Object is increased 
and status marked as confirm. Limit of Capacity field is mentioned in  Capacity field on Event. 
Once Capacity is reached Booking Field should be marked as Rejected.
Event Registration  
  Event Id
  Status
EventInfo - 
  Booking - Number 
  Capacity - Number 
*/
trigger TriggerScenario_21 on Event_Registration__c (before insert,before update) {
    Map<Id,Event_Registration__c> eventIdRegistration = new Map<Id,Event_Registration__c>();
    List<EventInfo__c> eventList = new List<EventInfo__c>();
    List<EventInfo__c> toUpdateEvent = new List<EventInfo__c>();
    List<Event_Registration__c> toUpdateEventRegistration = new List<Event_Registration__c>();
    
    for(Event_Registration__c er : Trigger.new){
         eventIdRegistration.put(er.EventInfo__c,er);
    }
	system.debug('eventIdRegistration'+eventIdRegistration);
    if(!eventIdRegistration.isEmpty()){
        eventList = [Select Id,Capacity__c,Bookings__c from EventInfo__c where Id in : eventIdRegistration.keySet()];
    }
   system.debug('eventList'+eventList);
    if(!eventList.isEmpty()){
        for(EventInfo__c eI : eventList){
            if(eI.Bookings__c <= eI.Capacity__c){
                eI.Bookings__c += 1;
           		eventIdRegistration.get(eI.Id).Status__c = 'Confirm';
            }else{
                eventIdRegistration.get(eI.Id).Status__c = 'Rejected';
            }       
            toUpdateEvent.add(eI);
        }
    }
    
    if(!toUpdateEvent.isEmpty()){
        update toUpdateEvent;
    }
}