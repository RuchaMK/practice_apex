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
1.	__AccountTrigger__
      /*Whenever New Account Record is created then needs to create associated Contact Record automatically.
        •account name as contact lastname
        •account phone as contact phone
         Object: Account
         Type: AfterInsert

      Creates the number of contacts which are equal to the number which we will enter in the Number of Locations field on the Account Object.
	    Create Custom field called “Number of Locations” on the Account Object (Data Type = Number)
*/
2.	__AccountUpdateTrigger__
3.	__AccountAfterUpdate__
4.	__CaseTrigger__
5.	__CaseTrigger_1__
6.	__ClosedWon__
7.	__ContactTrigger__
8.	__DuplicateAccount__
9.	__LeadSourceTrigger__
10.	__ProductCodeUpdate__
