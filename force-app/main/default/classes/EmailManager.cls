//Sending Mail and Custom Notification.
public class EmailManager {
    
    public static void sendMail(String address,String subject,String body){
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        String[] toAddress = new String[]{address};
        email.setToAddresses(toAddress);
        email.setSubject(subject);
        email.setPlainTextBody(body);
        
       Messaging.SendEmailResult[] results =  Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ email });
       inspectResults(results);
       
        //sending notification
        //CustomNotificationType notificationType = [SELECT Id,DeveloperName from CustomNotificationType where DeveloperName = 'Bell_Notification'];
        Set<String> users = new Set<String>();
        users.add(UserInfo.getUserId());
        CustomNotificationType notificationType = [SELECT Id,CustomNotifTypeName from CustomNotificationType where CustomNotifTypeName = 'Bell_Notification'];
        Messaging.CustomNotification notify = new Messaging.CustomNotification();
        notify.setNotificationTypeId(notificationType.id);
        notify.setTitle('This is title of your notification');
        notify.setBody('This is Body of your notification.'+'\n'+'Describe mail context');
        notify.setTargetId('000000000000000AAA');
        notify.send(users);
        
        //CustomNotification(typeId, sender, title, body, targetId, targetPageRef)
       
       
    }

    private static Boolean inspectResults(Messaging.SendEmailResult[] results){
        Boolean sendResult = true;
        for(Messaging.SendEmailResult res : results){
            if(res.isSuccess()){
                system.debug('Email Sent Successfully');
            }
            else{
              sendResult = false; 
              system.debug('Erros:' + res.geterrors());
            }
        }
        return sendResult;     
    }
}
/*
EmailManager.sendMail('Your email address', 'Title', '123 body');

https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_class_Messaging_CustomNotification.htm
*/