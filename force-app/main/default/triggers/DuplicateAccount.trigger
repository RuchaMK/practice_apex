/*The following Trigger will fires when we try to create the account with the same name
 i.e. Preventing the users to create Duplicate Accounts */
trigger DuplicateAccount on Account (before insert, before update) {
    for(Account acc: Trigger.New){
        List<Account> acclist = [Select Id from Account where Name =: acc.Name];
        if(accList.size() > 0){
            acc.Name.addError('Account Name already Exists!');
        }
    }

}