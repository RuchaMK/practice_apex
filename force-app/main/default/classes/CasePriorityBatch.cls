//Batch Apex using Iterable, stateful

/*public (Database.QueryLocator | Iterable<sObject>) start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
    }

    public void execute(Database.BatchableContext bc, List<P> records){
        // process each batch of records
    }    

    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }    
*/
public class CasePriorityBatch implements Database.Batchable<sObject>,Database.stateful {
      Integer i = 0;
    public List<Case> start(Database.BatchableContext bc){
      
        List<Case> caseList = [Select Id,Priority from Case where Priority = 'Low'];
        return caseList; 
        
    }
    
    public void execute(Database.BatchableContext bc, List<Case> caseList){
        i = i+1;
        for(Case c: caseList){
            c.priority = 'High';
        }
        system.debug('##Batch: ' + i + ' CaseList ' + caseList );
        update caseList;
    }
    
    public void finish(Database.BatchableContext bc){
        
    }
    
     public void execute(SchedulableContext sc){
        CasePriorityBatch cpb = new CasePriorityBatch();
        Database.executeBatch(cpb);
         /*
        chron = 'sec min hour day month day of week year'
        String schedon2 = '0 0 0/2 1/1 * ? *';
        At second :00, at minute :00, every 2 hours starting at 00am, every day starting on the 1st, every month
        CasePriorityBatch cpb = new CasePriorityBatch();
        System.schedule('CasePriorityBatch', schedon2, cpb);
        */
    }

}