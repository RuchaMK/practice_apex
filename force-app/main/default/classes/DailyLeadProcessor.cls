public with sharing class DailyLeadProcessor implements Schedulable {
    public void execute(SchedulableContext sc){
        List<Lead> leadList = [SELECT id,LeadSource FROM Lead WHERE LeadSource = null LIMIT 200];
        List<Lead> updatedLeadList = new List<Lead>();
        for(Lead l:leadList){
            l.LeadSource = 'Dreamforce';
            updatedLeadList.add(l);
        }
        update updatedLeadList;
    }
}