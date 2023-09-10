//When the checkbox (Assign Manager) is checked automatically assign
//a manager to user based on their team. **you can throw error on no user in team
trigger TriggerScenario_16 on User (before insert) {
	Set<String> teamName = new Set<String>();
    List<User> managerList = new List<User>();
    Map<String,User> managerMap = new Map<String,User>();
    
    if(!Trigger.new.isEmpty()){
        for(User us : Trigger.new){
            if(us.Team__c != null && us.Assign_Manager__c == true){
                teamName.add(us.Team__c); //list of team names
            }
        }
        
        if(!teamName.isEmpty()){
            managerList = [SELECT Id,Team__c from User where Team__c in: teamName and isActive = true]; //managers in team
        }
            if(!managerList.isEmpty()){
                for(User mng: managerList){
                    managerMap.put(mng.Team__c,mng);
                }
            }            
                if(!Trigger.new.isEmpty()){
            for(User us: Trigger.new){
                if(us.Assign_Manager__c==true){
                if(managerMap.containsKey(us.Team__c)){//is there a user in manager Map
                    us.ManagerId = managerMap.get(us.Team__c).Id;
                }else{
                    us.addError('There is no user in Team '+ us.Team__c + 'to assign as Manager.');
                }
                }
                
            }
                }
         
        
    }
}

/*
TC1: User add,team - error
TC2: User no team - skip
TC3: User assign mng unchecked - skip
TC4: User assign mng checked - mng
TC5: Multiple User assign mng checked - mng
*/