/*Write an Apex trigger that counts the number of contacts deleted related to an account.*/
trigger TriggerScenario_23 on Contact (before delete, after undelete) {
    Map<Id, Integer> accMap = new Map<Id, Integer>();
    List<Account> accList = new List<Account>();
    List<Account> updateAccList = new List<Account>();

    if (Trigger.isDelete) {
        for (Contact con : Trigger.old) {
            system.debug('1'+con);
            if (con.AccountId != null) {
                if (accMap.containsKey(con.AccountId)) {
                    accMap.put(con.AccountId, accMap.get(con.AccountId) + 1);
                }else {
                    accMap.put(con.AccountId, 1);
                } 
            }
        }
    }

    if (Trigger.isUndelete) {
        for (Contact con : Trigger.new) {
            system.debug('2'+con);
            if (con.AccountId != null) {
                if (accMap.containsKey(con.AccountId)) {
                    accMap.put(con.AccountId, accMap.get(con.AccountId) + 1);
                }else {
                    accMap.put(con.AccountId, 1);
                } 
            }
        }
    }

    if (!accMap.isEmpty()) {
        system.debug('accMap'+accMap);
        accList = [Select Id, Number_of_deleted_Contacts__c from Account where Id in :accMap.keySet()];
    }

    if (!accList.isEmpty()) {
        for (Account acc : accList) {
              if (Trigger.isDelete) {
            	acc.Number_of_deleted_Contacts__c = acc.Number_of_deleted_Contacts__c + accMap.get(acc.Id);
              }else if (Trigger.isUnDelete) {
                 acc.Number_of_deleted_Contacts__c = acc.Number_of_deleted_Contacts__c - accMap.get(acc.Id); 
              }
            updateAccList.add(acc);
        }
    }

    if (!updateAccList.isEmpty()) {
        update updateAccList;
    }
}

