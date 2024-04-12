@isTest
private class CaseManagerTest {
    
    static Id createTestRecord(){
        Case newCase = new Case(Subject = 'Test record', Status = 'New', Origin = 'Phone', Priority = 'Medium');
        insert newCase;
        return newCase.Id;
    }
    
    @isTest static void testGetCaseById(){
        Id recId = createTestRecord();
        RestRequest req = new RestRequest();
        req.requestURI = 'https://wise-moose-jekuwn-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Cases'+ recId;
        req.httpMethod = 'GET';
        RestContext.request = req;
        Case newCase = CaseManager.getCaseById();
        system.assert(newCase != null);
        System.assertEquals('Test record', newCase.Subject);
    }
    
    @isTest static void testCreateCase(){
        Id recId = CaseManager.createCase('testCreateCasesubject', 'New', 'Web', 'Low');
        system.assert(recId != null);
        Case newCase = [SELECT Id,Subject FROM Case WHERE Id =: recId];
        System.assertEquals(newCase.Subject,'testCreateCase');
    }
    
    @isTest static void testDeleteCase(){
        Id recId = createTestRecord();
        RestRequest req  = new RestRequest();
        req.requestURI = 'https://wise-moose-jekuwn-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Cases'+ recId;
        req.httpMethod = 'DELETE';
        RestContext.request = req;
        CaseManager.deleteCase();
        List<Case> caseList = [SELECT Id,Subject FROM Case WHERE Id =: recId];
        System.assert(caseList.size() == 0);
    }
    
     @isTest static void testUpsertCase() {
        // 1. Insert new record
        ID case1Id = CaseManager.upsertCase(
                'Ferocious chipmunk', 'New', 'Phone', 'Low', null);
        // Verify new record was created
        System.assert(Case1Id != null);
        Case case1 = [SELECT Id,Subject FROM Case WHERE Id=:case1Id];
        System.assert(case1 != null);
        System.assertEquals(case1.Subject, 'Ferocious chipmunk');
        // 2. Update status of existing record to Working
        ID case2Id = CaseManager.upsertCase(
                'Ferocious chipmunk', 'Working', 'Phone', 'Low', case1Id);
        // Verify record was updated
        System.assertEquals(case1Id, case2Id);
        Case case2 = [SELECT Id,Status FROM Case WHERE Id=:case2Id];
        System.assert(case2 != null);
        System.assertEquals(case2.Status, 'Working');
    }     
    @isTest static void testUpdateCaseFields() {
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.my.salesforce.com/services/apexrest/Cases/'
            + recordId;
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"status": "Working"}');
        RestContext.request = request;
        // Update status of existing record to Working
        ID thisCaseId = CaseManager.updateCaseFields();
        // Verify record was updated
        System.assert(thisCaseId != null);
        Case thisCase = [SELECT Id,Status FROM Case WHERE Id=:thisCaseId];
        System.assert(thisCase != null);
        System.assertEquals(thisCase.Status, 'Working');
    }  
}