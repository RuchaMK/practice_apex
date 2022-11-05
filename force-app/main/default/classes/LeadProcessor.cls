public class LeadProcessor implements Database.Batchable<SObject>{

public Database.QueryLocator start(Database.BatchableContext bc){

return Database.getQueryLocator([SELECT LeadSource from Lead]);
}

public void Execute(Database.BatchableContext bc,List<Lead> lead){
	List<Lead> toUpdate = new List<Lead>();
		for(Lead l:lead){
		l.LeadSource = 'Dreamforce';
		toUpdate.add(l);
		}

	update toUpdate;

}

public void finish(Database.BatchableContext bc){

}

}