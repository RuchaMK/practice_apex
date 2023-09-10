/*TriggerScenario_1 Roll Up Summary - Count number of contacts on Account using trigger .*/
trigger TriggerScenario_15 on Contact (before insert, before update, after delete, after undelete) {
    Set<Id> accId = new Set<Id>();

    if(!Trigger.new.isEmpty()){
        for(Contact con : Trigger.new){
            accId.(con.AccountId);
        }
    }
    if(!Trigger.old.isEmpty()){
        for(Contact con : Trigger.old){
            accId.(con.AccountId);
        }
    }
    List<Account> accList = [Select Id, (Select Id from Contacts) from Account where Id in: accId];
    List<Contact> toUpdateAcc = new List<Contact>();
    if(!accList.isEmpty()){
        for(Account acc: accList){
            acc.Count__c = acc.Contacts.size();
            toUpdateAcc.add(acc);
        }
    }
    if(!toUpdateAcc.isEmpty()){
        update toUpdateAcc;
    }
}