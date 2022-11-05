//HttpGet based on Id
@RestResource(urlMapping = '/Account/*')
global class AccountManager {
    @HttpGet
    global static Account getAccountById(){
        RestRequest request = RestContext.request;
        String accId = request.requestURI.subString(request.requestURI.lastIndexOf('/')+1);
        Account acc = [Select Name,AccountNumber,Industry,AnnualRevenue from Account where Id=:accId];
        return acc;
    }
    
    @HttpPost
    global static Id createAccount(String name,String accnum,String industry,Double ar){
        Account newAcc = new Account(Name = name,AccountNumber = accnum,Industry = industry,AnnualRevenue = ar);
        insert newAcc;
        return newAcc.Id;
    }
    
    @HttpPut
    global static Id upsertAccount(String Id,String name,String accnum,String industry,Double ar){
        //if Id is passed in parameters upsert else insert
        Account newAcc = new Account(Id = Id,Name = name,AccountNumber = accnum,Industry = industry,AnnualRevenue = ar);
        upsert newAcc;
        return newAcc.Id; 
    }
    
     @HttpPatch
    global static Id updateAccount(){
        RestRequest request = RestContext.request;
        String accId = request.requestURI.subString(request.requestURI.lastIndexOf('/')+1);
        Account updAcc = [Select Id from Account where Id=:accId];
        Map<String,Object> params = (Map<String,Object>)JSON.deserializeUntyped(request.requestBody.toString()); 
        for(String fieldName: params.keySet()){
            updAcc.put(fieldName,params.get(fieldName));
        }
        update updAcc;
        return updAcc.Id;
    }
    
    @HttpDelete
    global static void deleteAccount(){
        RestRequest request = RestContext.request;
        String accId = request.requestURI.subString(request.requestURI.lastIndexOf('/')+1);
        Account delAcc = [Select Id from Account where Id=:accId];
        delete delAcc;
    }
}
/*
GET
/services/apexrest/Account/0015j00000CwQ4fAAF

Name: Burlington Textiles Corp of America
AccountNumber: CD656092
Industry: Apparel
AnnualRevenue: 350000000
Id: 0015j00000CwQ4fAAF

POST
/services/apexrest/Account/

Request Body:
{
  "name": "New Account",
  "accnum": "123532",
  "industry": "My Industry",
  "ar": 7126412.2242
}

PUT
/services/apexrest/Account/

{
  "name": "Put Account",
  "accnum": "123532",
  "industry": "Put Industry",
  "ar": 7126412.2242
}

/services/apexrest/Account/

{
  "Id": "0015j00000eQb5XAAS" ,
  "name": "upsert Account",
  "accnum": "0012372",
  "industry": "upsert Industry",
  "ar": 12.2242
   
}

PATCH
/services/apexrest/Account/0015j00000eQb5XAAS

{
  "name": "patch Account"   
}

DELETE
/services/apexrest/Account/0015j00000CwQ4eAAF

Raw Response
HTTP/1.1 200 OK
*/