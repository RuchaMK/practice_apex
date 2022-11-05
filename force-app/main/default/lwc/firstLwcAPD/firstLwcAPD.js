import { LightningElement,api,wire } from 'lwc';
import getAccounts from '@salesforce/apex/ApexLwcBasic.getAccounts';
import getContacts from '@salesforce/apex/ApexLwcBasic.getContacts';

export default class FirstLwcAPD extends LightningElement {
    msg='Please fill above details';
    inputCompanyName='';
    @api msgData = 'Company informatiion';
    result;
    error;

    handlePreview(event){
        this.inputCompanyName = event.target.value;
        window.console.log('preview: ',event.target); 
    }

    //invoked by an event
    handleSave(event){
        alert('**Display Contacts?**');
        getContacts()
          .then(result => {
            this.result = result;
            this.error = undefined;
            console.log('Result', result);
          })
          .catch(error => {
            this.result = undefined;
            this.error = error;
            console.error('Error:', error);
        });
       
    }
    
    //not invoked by event
    @wire(getAccounts) 
    wiremethod({error,data}){
            if(data){
                this.result = data;
                this.error = undefined;
                window.console.log('**Data: ',data);
            }else if(error){
                this.error = error;
                this.result = undefined;
                window.console.log('**Error: ',error);
            }
        }
}