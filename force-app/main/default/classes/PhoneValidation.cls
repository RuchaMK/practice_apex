public class PhoneValidation {
    
    @invocablemethod(Label='Verify Phone Numbers'Description='Invoke API Call to verify Phone Number')
    public static List<Boolean> invokeValidatePhone(List<String> phoneNumbers){
        validateAccoutPhoneNumber.phoneWrapper pw = validateAccoutPhoneNumber.validatePhone(phoneNumbers[0]);       
        return new List<Boolean>{pw.phone_valid};
    }

}