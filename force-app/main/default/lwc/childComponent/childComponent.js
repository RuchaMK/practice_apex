import { LightningElement,api } from 'lwc';

export default class ChildComponent extends LightningElement {
@api childMessage;

@api
childCalled(parentName){
 alert('Call Child ?');
 this.childMessage = "Hi I am Child Component my Parent is " + parentName ;
}

//child to Parent
//Create obj of Custom event 
//send json object or value, best practice to not end sobjcet as they can't be modified 
//const event = new CustomEvent('eventname',{detail:{}})
//call event in parent by using 'on'
    sendToParent(){
    const myevent = new CustomEvent('btnclick',{
        detail: {
            key : '20',
            value : '100'
        }
    });
    this.dispatchEvent(myevent);
   }
}