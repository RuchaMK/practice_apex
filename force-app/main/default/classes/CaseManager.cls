//rest resource, global, global static, @
@RestResource(urlMapping = '/Cases/*')
global with sharing class CaseManager {
	@HttpGet 
    global static Case getCaseById(){
        RestRequest req = RestContext.request;
        //extract case id from request url
        //requestURI - 
        //lastindexof - returns last occurence indexof string
        //subString - returns a new string from given index
        String caseId = req.requestURI.subString(req.requestURI.lastIndexOf('/') + 1);
        Case result = [Select CaseNumber, Subject, Status, Origin, Priority
                       FROM Case
                       WHERE Id =: caseId];
        
        return result;
    }
    
    @HttpPost
    global static Id createCase(String subject, string status, String origin, String priority){
        Case newCase = new Case(Subject = subject, Status = status, Origin = origin, Priority = priority);
        insert newCase;
        return newCase.Id;
    }
    
    @HttpPut
    global static Id upsertCase(String subject, string status, String origin, String priority, String Id){
        Case newCase = new Case(Id = Id,Subject = subject, Status = status, Origin = origin, Priority = priority);
        upsert newCase;
        return newCase.Id;
    }
    
    @HttpPatch
    global static Id updateCaseFields(){
        RestRequest req = RestContext.request;
        system.debug('Substring '+req.requestURI.lastIndexOf('/') + ' ' + req.requestURI.subString(req.requestURI.lastIndexOf('/')+1));
        String caseId = req.requestURI.subString(req.requestURI.lastIndexOf('/')+1);
        Case thisCase = [Select Id from Case where Id =: caseId];
        Map<String,Object> params = (Map<String,Object>)JSON.deserializeUntyped(req.requestbody.toString());
        for(String fieldName : params.keySet()){
            thisCase.put(fieldName,params.get(fieldName));//used to update the field directly
        }
        update thisCase;
        return thisCase.Id;
    }
    
    @HttpDelete
    global static void deleteCase(){
        RestRequest req = RestContext.request;
        String caseId = req.requestURI.subString(req.requestURI.lastIndexOf('/')+1);
        Case deleteCase = [Select Id from Case where Id =: caseId];
        delete deleteCase;    
    }
}
/*
/services/apexrest/Cases
POST
URL.getSalesforceBaseUrl().toExternalForm()
{
  "subject" : "Bigfoot Sighting!",
  "status" : "New",
  "origin" : "Phone",
  "priority" : "Low"
}
PUT
/services/apexrest/Cases
{
  "Id": "5005i00000fKe4HAAS",
  "status" : "Working",
  "subject" : "Bigfsoot Sighting!",
  "priority" : "Medium"
}
PATCH
/services/apexrest/Cases/5005i00000fKe4HAAS
{
  "status" : "Escalated",
  "priority" : "High"
}
GET
/services/apexrest/Cases/5005i00000fKe4HAAS
*/