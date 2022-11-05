import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {
 parentMessage = "Private Parent Message";


 handleClick(){
this.parentMessage = 'Action Detected:You Clicked the button!!';
 }

 childCall(){
    //this.template.querySelector('selector').funcName(parameter)
   this.template.querySelector('c-child-component').childCalled("Mr. RK");
 }
 handleEvent(event){
    let rollno = event.detail.key;
    let marks = event.detail.value;
    this.parentMessage = 'This is my Roll No: ' + rollno + '. These are my Marks: '+ marks;
 }

}