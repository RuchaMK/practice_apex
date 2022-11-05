@isTest
public class  LeadProcessorTest{

@testsetup
public static void init(){
	List<Lead> leads = new List<Lead>();

	for(Integer i =0;i<200;i++){
	leads.add(new Lead(Company='c'+i,LastName='ls'+i,status='Open-Not Contacted'));
	}
	insert leads;
}

@isTest
public static void runBatch(){
LeadProcessor lp = new LeadProcessor();
id batchId = Database.executebatch(lp);

System.assertEquals(200,[SELECT count() from Lead]);

}


}