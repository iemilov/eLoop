import { LightningElement, track, api, wire } from 'lwc';
import getImages from '@salesforce/apex/ServiceStatusController.getImages';
import getComments from '@salesforce/apex/ServiceStatusController.getComments';


export default class ImgList extends LightningElement {


    @track images = [];
    @track comments = [];
    @track recordId;
    @track currentstatus;

    @api getIdFromParent;

    @api
    get itemName() {
        return this._itemName;
    }

    set itemName(value) {
        this.currentstatus=value;
    }
    
  
    @wire(getImages, {caseId :'$getIdFromParent', status :'$currentstatus'})
    LoadImages(result) {
        if (result.data) {
            this.images = result.data;
        }
    }

    @wire(getComments, {caseId :'$getIdFromParent', status :'$currentstatus'})
    LoadComments(result) {
        if (result.data) {
            this.comments = result.data;
        }
    }
}