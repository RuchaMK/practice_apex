@isTest
public with sharing class DailyLeadProcessorTest {
  
    @TestSetup
    static void initData(){
        List<Lead> leadList = new List<Lead>();
        for(Integer i=0;i<200;i++){
        leadList.add(new Lead(LastName = 'Last'+i, Company = 'CO'+i, Status= 'Open - Not Contacted',LeadSource = ''));
        }
        insert leadList;
    }

    @isTest
    static void testScheduler(){
        String sch = '20 30 8 10 2 ?'; 
        Test.startTest();
        Id jobId = System.schedule('DailyLeadProcessor', sch, new DailyLeadProcessor());
        Test.stopTest();
    }

}