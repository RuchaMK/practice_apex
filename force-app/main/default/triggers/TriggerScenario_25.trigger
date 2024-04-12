/*When a User gets deactivated from org then assign all open opportunity records to manager. 
  User -> LookUp -> Manager
  User has many ---> Opportnuity.Status = 'Open' -> Reassign */
  trigger TriggerScenario_25 on User (after Update) {
    
    Map<Id,Id> managerIdByUserId = new Map<Id,Id>();
    List<Opportunity> toUpdateOpportunity = new List<Opportunity>();
    
    for(User usr : Trigger.new){
        if(usr.isActive == false && Trigger.oldMap.get(usr.Id).isActive == true){
            managerIdByUserId.put(usr.Id,usr.ManagerId);
        }
    }
    if(managerIdByUserId.isEmpty()){
        return;
    }
    for(Opportunity op : [Select Id, OwnerId, IsClosed from Opportunity where OwnerId in : managerIdByUserId.keySet() and IsClosed = False]){
        op.OwnerId = managerIdByUserId.get(op.OwnerId);
        toUpdateOpportunity.add(op);
    }
    if(!toUpdateOpportunity.isEmpty()){
        try{
            update toUpdateOpportunity;
        }catch(Exception ex){
            system.debug('Error while updating Opportunity'+ex.getMessage());
        }    
    }    
   /* for(User usr : Trigger.new){
        if(usr.isActive == false && Trigger.oldMap.get(usr.Id).isActive == true){
            deactivateUserIds.add(usr.Id);
        }
    }
    if(deactivateUserIds.isEmpty()){
        return;
    }
    
    for(User usr : [Select Id, ManagerId from User where Id in : deactivateUserIds]){
        if(usr.ManagerId != null){
            managerIdByUserId.put(usr.Id,usr.ManagerId);
        }
    }
    
    if(managerIdByUserId.isEmpty()){
        return;
    }
    for(Opportunity op : [Select Id, OwnerId, IsClosed from Opportunity where OwnerId in : deactivateUserIds and IsClosed = False]){
        op.OwnerId = managerIdByUserId.get(op.OwnerId);
        toUpdateOpportunity.add(op);
    }
    */
   
}

//Not TESTEd