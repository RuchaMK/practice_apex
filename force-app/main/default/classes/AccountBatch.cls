/*Apex Batch class to copy Account Description to Contact Description  */
public class AccountBatch implements Database.Batchable<sObject>{
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select Description, (Select Description From Contacts) from Account]);
    }   
	
    public void execute(Database.BatchableContext bc, List<Account> accountList){
        
        for(Account acc : accountList){
            for(Contact con : acc.Contacts){
                con.Description = acc.Description;
            }
        }
    }
    
    public void finish(Database.BatchableContext bc){
        // Get the ID of the AsyncApexJob representing this batch job
        AsyncApexJob jobId = [SELECT Id ,Status, JobItemsProcessed,TotalJobItems FROM AsyncApexJob where Id =: bc.getJobId() ];
       system.debug('***jobId ' + jobId);
            
    }
}

/*
Command 
AccountBatch ab = new AccountBatch();
Database.executeBatch(ab);*/