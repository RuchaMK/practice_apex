global class ParkServiceMock implements WebServiceMock{
	//doInvoke(Object, Object, Map<String,Object>, String, String, String, String, String, String)
   global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
        // start - specify the response you want to send
        ParkService.byCountryResponse response_x = new  ParkService.byCountryResponse();
        String[] result = new String[]{'Anamudi Shola National Park', 'Anshi National Park', 'Bandipur National Parks'};
        response_x.return_x = result;
        // end
        response.put('response_x', response_x); 
   }
}