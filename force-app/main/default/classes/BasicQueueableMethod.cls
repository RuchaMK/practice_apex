public class BasicQueueableMethod implements Queueable{
    
    public void execute(QueueableContext context){
        Account acc = [Select Id, Name From Account Limit 1][0];
        
        System.debug('Accounts in Queeu: ' + acc);
    }
    

}

/*
BasicQueueableMethod bqm = new BasicQueueableMethod();
Id jobId = System.enqueueJob(bqm);


check in jobs

*/