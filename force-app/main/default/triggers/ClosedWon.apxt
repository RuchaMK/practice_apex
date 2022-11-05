trigger ClosedWon on Opportunity (before Update) {
    
    for(Opportunity opp : Trigger.new){
        Opportunity oldOpp = Trigger.OldMap.get(opp.id);//getting older version of record
        Boolean oldOppIsWon = oldOpp.StageName.equals('Closed Won');
        Boolean newOppIsWon = opp.StageName.equals('Closed Won');
        if(!oldOppIsWon && newOppIsWon){
            //update a map
        }
    }

}