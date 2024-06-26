/*Create an Apex REST service that returns an account and its contacts.
Create an Apex REST class that is accessible at /Accounts/<Account_ID>/contacts. The service will return the account's ID and name plus the ID and name of all contacts associated with the account. Write unit tests that achieve 100% code coverage for the class and run your Apex tests.
Prework: Be sure the Remote Sites from the first unit are set up.
Create an Apex class
Name: AccountManager
Class must have a method called getAccount
Method must be annotated with @HttpGet and return an Account object
Method must return the ID and Name for the requested record and all associated contacts with their ID and Name
Create unit tests
Unit tests must be in a separate Apex class called AccountManagerTest
Unit tests must cover all lines of code included in the AccountManager class, resulting in 100% code coverage
Run your test class at least once (via Run All tests the Developer Console) before attempting to verify this challenge*/
@RestResource(urlMapping = '/Accounts/*/contacts')
global class AccountManager {
    @HttpGet
    global static Account getAccount(){
        //requestURI=/Accounts/0015i00000nANI8AAO/contacts
        RestRequest req = RestContext.request;
        String accId = req.requestURI.substringBetween('/Accounts/','/contacts');
        System.debug('**'+accId);
        Account acc = [Select Id, Name, (Select Id, Name from Contacts) from Account where Id =: accId];
        return acc;
    }
}