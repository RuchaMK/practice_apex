Salesforce Practice Questions
#Aura

# Apex
1. __ParentChildApp__
2. __firstAuraAPD__


1.	__AccountBatch, AccountBatchTest__
2.	__AccountDML__
3.	__AccountHandler__
4.	__AccountManager__
5.	__AccountProcessor, AccountProcessorTest__
6.	__AddPrimaryContact, AddPrimaryContactTest__
7.	__ApexData__
8.	__ApexLwcBasic__
9.	__BasicFutureMethod__
10.	__BasicQueueableMethod__
11.	__CaseManager__
12.	__CasePriorityBatch__
13.	__ContactAndLeadSearch__
14.	__ContactInfoUpdate__
15.	__ContactListDatabase__
16.	__ContactListDml__
17.	__ContactSearch__
18.	__ContactTriggerHandler__
19.	__CountryCodeHelper__
20.	__DailyLeadProcessor, DailyLeadProcessorTest__
21.	__EmailManager__
22.	__EnumExamples__
23.	__Extra__
24.	__LeadProcessor, LeadProcessorTest__
25.	__OlderAccountsUtility__
26.	__SpoonacularResponse__
27.	__StringArrayTest__
28.	__enumDataType____

# LWC 
1. __childComponent__
2. __dish__
3. __dishMenu__
4. __rstLwcAPD__
5. __lds__
6. __parentComponent__

# Triggers
1.	__AccountTrigger__\
      Whenever New Account Record is created then create associated Contact Record automatically.
        •account name as contact lastname
        •account phone as contact phone
         Object: Account
         Type: AfterInsert

      Create the number of contacts which are equal to the number which we will enter in the Number of Locations field on the Account Object.
	    Create Custom field called “Number of Locations” on the Account Object (Data Type = Number)

2.	__AccountUpdateTrigger__
	Add Account Phone no to related contact Phone no
3.	__AccountAfterUpdate__
4.	__CaseTrigger__
	1. Whenever a case is created with origin as ‘Phone’ then 
	set status as ‘New’ and Priority as ‘High’.
5.	__CaseTrigger_1__
    1. When ever a case is created with origin as Email then set status as new and Priority as Medium.
 		Object: Case
 		Type: Before Insert -- Trigger.New
6.	__ClosedWon__
7.	__ContactTrigger, ContactTriggerHandler__ 
	  /*Prob 1:
		* Prevent Duplicates on Contact 
		1.No duplicate 
		2.Duplicates allowed but not within same account
		use  row locking (FOR UPDATE)
		This can be made using workflow but it fails for undelete case or if unrelated field is updated.
		Solution:
		1. Make a list using trigger.new - newContactEmails.
		2. Query ExistingContactList by checking existingContactEmails in database.
		Here take email to check duplicates.
		Prob 2:
		Prevent duplicate contacts on same account
		*/
8.	__DuplicateAccount__\
	The Trigger will fire when we try to create the account with the same name
 	i.e. Preventing the users to create Duplicate Accounts
9.	__LeadSourceTrigger__\
	While inserting Lead if LeadSource = 'Web' then make rating = Cold.
10.	__ProductCodeUpdate__\
	Add 'PRC' brefore inserting a product record.
11. __TriggerScenario_1__
	Roll Up Summary - Count number of contacts on Account using trigger .
12. __TriggerScenario_2__\
	P-C: Whenever phone is modified on account object then update contact record with phone field.
13. __TriggerScenario_3__\
	Prevent Account from deleting if it has 2 or more contacts.
14. __TriggerScenario_4__\
	Unrelated Objects - While creating or updating Lead check whether Email is already there in existing contact, 
	if it is there then throw an error.
15.    __TriggerScenario_5__\
	Whenever Lead is created with lead Source as WEB then give rating as COLD otherwise HOT .
16. __TriggerScenario_6__\
	C-P: Update Parent Whenever a contacts description is updated then its parent account's description should get updated by related contact desc.
17. __TriggerScenario_7__\
	Conditional Creation of Child
	Trigger to create a related Contact on Account with same Phone as Account if custom field checkbox is checked on Account
18. __TriggerScenario_8__\
	You have a custom object called "CustomInvoice__c" with a master-detail relationship to the standard object "Account".
	You want to update the "Account" custom field Last Invoice DateTime with Date  whenever a related "CustomInvoice__c" record is created or updated.
19.  __TriggerScenario_9__\
	C-P: Roll Up Summary - Find sum of all related Opportunities Amount and update on related Account. Create a field Opportunity amount on Account object and write a trigger on Opportunity to populate the total sum of all opportunity Amount on Account Object Opportunity amount field
20.  __TriggerScenario_10__\
	You have a custom object called "Opportunity__c" with a field named "Stage__c". Whenever an Opportunity record is updated to change the Stage to "Closed Won", you need to create a new "Revenue__c" record with the same amount as the Opportunity's "Amount__c" field.
21.  __TriggerScenario_11__\
	Develop an Apex trigger that sets the Account owner as the default opportunity owner for newly created Opportunities.
22.  __TriggerScenario_12__\
	Implement an Apex trigger to enforce field-level security on a custom field based on the User’s profile.
23.  __TriggerScenario_13__\
	To Prevent The User From Creating Duplicate Contacts When A Contact Already Exists With The Same Email.
	Prevent Duplicate contacts based on Email
23.  __TriggerScenario_14__\
	Prevent Duplicate Contact with same Last Name and on same Account
23.  __TriggerScenario_15__\
	Roll Up Summary - Count number of contacts on Account using trigger
23.  __TriggerScenario_16__\
	When the checkbox (Assign Manager) is checked automatically assign
	a manager to user based on their team. 
	(you can throw error on no user in team)
24. __TriggerScenario_17__\
	Prevent Multiple Primary Contact on Parent Account one Primary Contact per Account
25. __TriggerScenario_18__\
	Prevent Duplicates on Contact based on Phone number and LastName
26. __TriggerScenario_19__\
	Create 2 contacts if Account is inserted and 3 contacts if Account is updated.
	
