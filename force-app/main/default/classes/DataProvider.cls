public with sharing class DataProvider {

    @AuraEnabled
    public static List<Loan_Application__c> loanApplicationList() {
        try{
        return [SELECT Name, Stage__c
        FROM Loan_Application__c
        ORDER BY CreatedDate DESC NULLS LAST];
        }catch(Exception ex){
            throw new AuraHandledException(ex.getMessage());
        } 
    }
    
}