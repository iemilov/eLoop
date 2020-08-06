import { LightningElement, api, track } from 'lwc';
import createServiceFormular from '@salesforce/apex/ServiceStatusController.createServiceFormular';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class ModalTemplate extends LightningElement {

    @track firm;
    @track name;
    @track ebayName;
    @track email;
    @track model;
    @track seriennummer;
    @track fehlerbeschreibung;
    @track reparaturInAndererWerkstatt;
    @track warVorigeReparaturErfolgreich;
    @track festgestellteDiagnose;
    @track geraetIstGestuerzt;
    @track fluessigkeitenAufDasGeraet;
    @track eintrittDesDfektesUmstaende;
    @track weitereBekannteDefekte;


    @track error;
    @track open = false;

    @api getIdFromParent;

    @api 
    openmodal() {
        this.open = true
    }

    closeModal() {
        this.open = false
    }

    serviceFormular = {
        Firma: this.firm,
        Name : this.name,
        EbayName: this.ebayName,
        Contact__c: this.email,
        Hersteller_Modell__c: this.model,
        Seriennummer__c: this.seriennummer,
        Fehlerbeschreibung__c: this.fehlerbeschreibung,
        ReparaturInAndererWerkstatt__c: this.reparaturInAndererWerkstatt,
        WarVorigeReparaturErfolgreich__c: this.warVorigeReparaturErfolgreich,
        FestgestellteDiagnose__c: this.festgestellteDiagnose,
        GeraetIstGestuerzt__c: this.geraetIstGestuerzt,
        FluessigkeitenAufDasGeraet__c: this.fluessigkeitenAufDasGeraet,
        EintrittDesDfektesUmstaende__c: this.eintrittDesDfektesUmstaende,
        WeitereBekannteDefekte__c: this.weitereBekannteDefekte
    }

    handleFirma(event) {
        this.serviceFormular.Firma = event.target.value;
    }

    handleNameChange(event) {
        this.serviceFormular.Name = event.target.value;
    }

    handleEbayName(event) {
        this.serviceFormular.EbayName = event.target.value;
    }
    
    handleEmailChange(event) {
        this.serviceFormular.Contact__c = event.target.value;
    }

    handleModel(event) {
        this.serviceFormular.Hersteller_Modell__c = event.target.value;
    }

    handleSeriennummer(event) {
        this.serviceFormular.Seriennummer__c = event.target.value;
    }

    handleFhlerbeschreibung(event) {
        this.serviceFormular.Fehlerbeschreibung__c = event.target.value;
    }

    handleReparaturInAndererWerkstatt(event) {
        this.serviceFormular.ReparaturInAndererWerkstatt__c = event.target.checked;
    }

    handleWarVorigeReparaturErfolgreich(event) {
        this.serviceFormular.WarVorigeReparaturErfolgreich__c = event.target.checked;
    }

    handleFestgestellteDiagnose(event) {
        this.serviceFormular.FestgestellteDiagnose__c = event.target.value;
    }

    handleGeraetIstGestuerzt(event) {
        this.serviceFormular.GeraetIstGestuerzt__c = event.target.checked;
    }

    handleFluessigkeitenAufDasGeraet(event) {
        this.serviceFormular.FluessigkeitenAufDasGeraet__c = event.target.checked;
    }

    handleEintrittDesDfektesUmstaende(event) {
        this.serviceFormular.EintrittDesDfektesUmstaende__c = event.target.value;
    }

    handleWeitereBekannteDefekte(event) {
        this.serviceFormular.WeitereBekannteDefekte__c = event.target.value;
    }

    handleClick() {
        this.serviceFormular.Case__c=this.getIdFromParent;
        createServiceFormular ({ formular : this.serviceFormular, email: this.serviceFormular.Contact__c })
            .then(result => {
                this.message = result;
                //this.error = this.message.Response__c;
                //this.error = undefined;
                if(this.message !== undefined) {
                    this.serviceFormular.Name = '';
                    this.serviceFormular.Contact__c = '';

                    /*this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Service Formular created',
                            variant: 'success',
                        }),
                    );*/
                    this.closeModal();
                }
            })
            .catch(error => {
                this.message = undefined;
                this.error = error.body.message;

                /*this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );*/
            });
    }
}