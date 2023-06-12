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
3.	__AccountAfterUpdate__
4.	__CaseTrigger__
	1. Whenever a case is created with origin as ‘Phone’ then 
	set status as ‘New’ and Priority as ‘High’.
5.	__CaseTrigger_1__
6.	__ClosedWon__
7.	__ContactTrigger__
8.	__DuplicateAccount__\
	The Trigger will fire when we try to create the account with the same name
 	i.e. Preventing the users to create Duplicate Accounts
9.	__LeadSourceTrigger__\
	While inserting Lead if LeadSource = 'Web' then make rating = Cold.
10.	__ProductCodeUpdate__\
	Add 'PRC' brefore inserting a product record.
11. 	**TriggerScenario_1**
	Roll Up Summary - Count number of contacts on Account using trigger .
12. 	__TriggerScenario_2__\
	Whenever phone is modified on account object then update contact record with phone field.
13. 	__TriggerScenario_3__\
	Prevent Account from deleting if it has 2 or more contacts.
14.    __TriggerScenario_4__\
	Unrelated Objects - While creating or updating Lead check whether Email is already there in existing contact, 
	if it is there then throw an error.
15.    __TriggerScenario_5__\
	Whenever Lead is created with lead Source as WEB then give rating as COLD otherwise HOT .
16.    __TriggerScenario_6__\
	Update Parent Whenever a contacts description is updated then its parent account's description should get updated by related contact desc.
17.    __TriggerScenario_7__\
	Conditional Creation of Child
	Trigger to create a related Contact on Account with same Phone as Account if 
	custom field checkbox is checked on Account
18.    __TriggerScenario_8__\
	You have a custom object called "Invoice__c" with a master-detail relationship to the standard object "Account".
	You want to update the "Account" custom field Last Invoice Date  whenever a related "Invoice__c" record is created or updated.
19.    __TriggerScenario_9__\
	Roll Up Summary - Find sum of all related Opportunities Amount of an Account
