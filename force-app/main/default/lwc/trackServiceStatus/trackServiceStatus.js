import { LightningElement, api, track, wire } from 'lwc';
import fetchsObjectData from '@salesforce/apex/ServiceStatusController.fetchsObjectData';
import getCaseNumber from '@salesforce/apex/ServiceStatusController.getCaseNumber';


export default class TrackServiceStatus extends LightningElement {

    @api recordId;
    @track sObjData= [];
    @track caseNumber;
    @track error;

    open() {
        this.template.querySelector('c-modal').openmodal();
    }

    @wire(getCaseNumber, {caseId :'$recordId'} )
    GetcaseNumber({error, data}) {
        if (data){
            this.caseNumber = data.CaseNumber;
        }
        else if (error) {
            this.error = 'Unknown error, currently the status data can not be loaded';
        }
    }

    @wire(fetchsObjectData, {caseId :'$recordId'} )
    LoadStatusData({error, data}) {
        if (data){
            this.sObjData = data;
        }
        else if (error) {
            this.error = 'Unknown error, currently the status data can not be loaded';
        }
    }
}