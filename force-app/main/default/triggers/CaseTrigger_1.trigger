/*When ever a case is created with origin as Email then set status as new and Priority as Medium.
 Object: Case
 Type: Before Insert -- Trigger.New
 */
trigger CaseTrigger_1 on Case (before insert) {
	
    for(Case c : Trigger.new){
        if(c.Origin == 'Email'){
            c.Status = 'New';
            c.Priority = 'Medium';
        }
    }
}