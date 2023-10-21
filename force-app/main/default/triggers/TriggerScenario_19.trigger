/*Create 2 contacts if Account is inserted and 3 if is updated */
trigger TriggerScenario_19 on Account (after insert,after update) {
    List<Contact> conList = new List<Contact>();
	if(Trigger.isInsert){
        for(Account acc:Trigger.new){
            for(Integer i =0;i<2;i++){
                Contact con = new Contact(LastName = 'ConOnInsert'+i,AccountId = acc.Id);
                conList.add(con);
            }
        }        
    }else if(Trigger.isUpdate){
         for(Account acc:Trigger.new){
            for(Integer i =0;i<3;i++){
                Contact con = new Contact(LastName = 'ConOnUpdate'+i,AccountId = acc.Id);
                conList.add(con);
             }
         }
    }
    if(!conList.isEmpty()){
        insert conList;
    }
}