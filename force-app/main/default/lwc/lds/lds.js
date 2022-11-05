import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import StayInTouchSignature from '@salesforce/schema/User.StayInTouchSignature';

export default class Lds extends NavigationMixin(LightningElement) {
    contactId;

    hanldeError(){
        alert('Error');
    }
    handleSuccess(){
        
        alert('Success');
    }
    handleSubmit(){
        alert('Submit');
    }

    navigateToRecordDetailsPage(){
    
         this[NavigationMixin.Navigate]({
             type: 'standard__objectPage',
                 attributes: {
                 objectApiName: 'Account',
                 actionName: 'home'
             },
          });
       
    }


    
    createAccountRec(){
    
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
                attributes: {
                objectApiName: 'Account',
                actionName: 'new'
            },
         });
      
   }

  /* createContactRec(){
    this.template.queryselector('lightning-record-edit-form').submit(this.fields);
    //this.template.querySelector('lightning-record-edit-form').submit(this.fields);
    this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
            attributes: {
                recordId: this.recordId,
            objectApiName: 'Contact',
            actionName: 'view'
        },
     });
     
  
}*/
}