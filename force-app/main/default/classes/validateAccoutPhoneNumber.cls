public class validateAccoutPhoneNumber {
    
    public static phoneWrapper validatePhone(String phoneNum){
		 //endpoint -https://api.veriphone.io/v2/verify?phone=%2B49-15123577723&key=266B0091BC9547A2A40DD088795FA4C6
		 String url = System.Label.verifyPhoneUrl;
         String key = System.Label.verifyPhoneKey;
         String endpoint = url+phoneNum+'&key='+key;
         system.debug(endpoint);
		
         //Http
		 Http http = new Http();
        
		 //HttpRequest - endpoint, method, timeout
		 HttpRequest req = new HttpRequest();
         req.setEndpoint(endpoint);
         req.setMethod('GET');
                     
		 //HttpResponse - send
	     HttpResponse res = http.send(req);
         //public static Object deserialize(String jsonString, System.Type apexType)
         //class obj = (class)deserialize(jsonString,classname.class);
         phoneWrapper pw = (phoneWrapper)JSON.deserialize(res.getBody(), phoneWrapper.class);
         system.debug('Response'+pw);
		 return pw;      
    } 
    
    //wrapper
    public class phoneWrapper{
        public String status;
        public String phone;
        public Boolean phone_valid;
        public String phone_type;
        public String phone_region;
        public String country;
        public String country_code;
        public String country_prefix;
        public String international_number;
        public String local_number;
        public String e164;
        public String carrier;            
    }

}