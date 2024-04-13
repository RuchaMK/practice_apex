import { LightningElement } from 'lwc';
import getLoanApplications from'@salesforce/apex/DataProvider.loanApplicationList';

export default class LoanWorkList extends LightningElement {
    items

    connectedCallback(){
        getLoanApplications()
            .then(result => {
                console.log('**',result)
                this.items = [...result];
            })
            .catch(error=>{})
    }
}