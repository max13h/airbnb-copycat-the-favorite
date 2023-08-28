var googlePaymentsClient;
var googlePayPaymentInstance;

function initialiseGooglePay() {
    var paymentsClient = getGooglePaymentClient();

    braintree.googlePayment.create({
        client: client,
        googlePayVersion: 2,
        googleMerchantId: googleMerchantId // Optional in sandbox; if set in sandbox, this value must be a valid production Google Merchant ID
    }).then(function (googlePaymentInstance) {
        return paymentsClient.isReadyToPay({
            // see https://developers.google.com/pay/api/web/reference/object#IsReadyToPayRequest for all options
            apiVersion: 2,
            apiVersionMinor: 0,
            allowedPaymentMethods: googlePaymentInstance.createPaymentDataRequest().allowedPaymentMethods,
            existingPaymentMethodRequired: true
        }).then(function (isReadyToPay) {
            if (isReadyToPay.result) {
                googlePayPaymentInstance = googlePaymentInstance;

                if (checkGooglePayAvailability()) {
                    $('#googlepay').removeClass(CONST.HIDE);
                    checkSavedPaymentMethods(CONST.GOOGLE_PAY_ACCOUNT, isReadyToPay.result);
                } else {
                    renderGooglePayButton(paymentsClient, googlePaymentInstance);
                }

            }else{
                console.log("reuslt false")
            }
        }).catch(function (err) {
            // Handle creation errors
            console.error('An error occurred during creation:', err.message);
        });
    });
}



function setupGooglePayButton(){
    var paymentsClient = getGooglePaymentClient();
    let waitForGooglePayInstance = setInterval(function () {
        if (typeof googlePayPaymentInstance !== "undefined") {
            clearInterval(waitForGooglePayInstance);
            if (googlePayPaymentInstance != ''){
                renderGooglePayButton(paymentsClient, googlePayPaymentInstance);
            }
        }
        console.log("wait for GooglePayInstance to be loaded")
    }, 10);


}


function checkGooglePayAvailability() {
    if (typeof paymentMethodsPage != 'undefined' || typeof addPaymentMethodsPage != 'undefined' ||
        typeof accountPaymentInfoPage != 'undefined') {
        return true;
    }
    return false;
}

function renderGooglePayButton(paymentsClient, googlePaymentInstance) {
    var buttonContainers = document.getElementsByClassName("google_pay_container");
    const button = paymentsClient.createButton({ onClick: () => onGooglePaymentButtonClicked(paymentsClient, googlePaymentInstance) });
    if (typeof paymentMethodsPage == 'undefined' || paymentMethodsPage === '') {
        button.firstChild.className += ' google-pay-button-style';
    } else {
        button.firstChild.className += ' google-pay-mark-button-style';
    }
    Array.from(buttonContainers).forEach(function (item) {
        if (!item.hasChildNodes()) {
            item.appendChild(button);
        }
    });
}

function getGooglePaymentClient() {
    if (typeof googlePaymentsClient == 'undefined' || googlePaymentsClient === '') {
        var localEnvironment = environment.toUpperCase() === 'PRODUCTION' ? 'PRODUCTION' : 'TEST';
        googlePaymentsClient = new google.payments.api.PaymentsClient({
            environment: localEnvironment
        });
    }
    return googlePaymentsClient;
}

function onGooglePaymentButtonClicked(paymentsClient, googlePayPaymentInstance) {
    var paymentDataRequest = getGooglePaymentDataRequest(googlePayPaymentInstance);

    // See all available options at https://developers.google.com/pay/api/web/reference/object
    var cardPaymentMethod = paymentDataRequest.allowedPaymentMethods[0];
    paymentDataRequest.emailRequired = true;
    cardPaymentMethod.parameters.billingAddressRequired = true;
    cardPaymentMethod.parameters.billingAddressParameters = {
        format: 'FULL',
        phoneNumberRequired: true
    };

    if ((typeof paymentMethodsPage == 'undefined' || paymentMethodsPage == '') 
        && (typeof addPaymentMethodsPage == 'undefined' || addPaymentMethodsPage == '')) {

        paymentDataRequest.shippingAddressRequired = true;
    }

    var googlePayPaymentData;

    paymentsClient.loadPaymentData(paymentDataRequest).then(function (paymentData) {
        googlePayPaymentData = paymentData;
        return googlePayPaymentInstance.parseResponse(paymentData);
    }).then(function (result) {
        processGooglePayResponse(result, googlePayPaymentData);
    }).catch(function (err) {
        // Handle errors
        console.error('An error occurred:', err.message);
    });
}

function getGooglePaymentDataRequest(googlePayPaymentInstance) {
    var paymentDataRequest;

    if (typeof addPaymentMethodsPage != 'undefined'){
        paymentDataRequest = googlePayPaymentInstance.createPaymentDataRequest({
            transactionInfo: {
                countryCode: googlePayCountryCode,
                currencyCode: currency,
                totalPriceStatus: 'FINAL',
                totalPrice: '0.0'
            }
        });
    }else {
        paymentDataRequest = googlePayPaymentInstance.createPaymentDataRequest({
            transactionInfo: {
                countryCode: googlePayCountryCode,
                currencyCode: currency,
                totalPriceStatus: 'FINAL',
                totalPrice: amount
            }
        });    
    }
    return paymentDataRequest;
}


function processGooglePayResponse(response, googlePayPaymentData) {

    var payload = convertGoogleDataToPayloadObject(response, googlePayPaymentData);

    processExpressCheckoutForm(payload, false);
}


function convertGoogleDataToPayloadObject(response, googlePayPaymentData) {
    var payloadCopy = {};
    payloadCopy.nonce = response.nonce;
    payloadCopy.details = {};
    payloadCopy.type = response.type;
    payloadCopy.details.email = googlePayPaymentData.email;

    payloadCopy.details.phone = googlePayPaymentData.paymentMethodData.info.billingAddress.phoneNumber;
    payloadCopy.details.billingAddress = {
        line1: googlePayPaymentData.paymentMethodData.info.billingAddress.address1,
        line2: googlePayPaymentData.paymentMethodData.info.billingAddress.address2,
        city: googlePayPaymentData.paymentMethodData.info.billingAddress.locality,
        state: googlePayPaymentData.paymentMethodData.info.billingAddress.administrativeArea.toUpperCase(),
        postalCode: googlePayPaymentData.paymentMethodData.info.billingAddress.postalCode,
        countryCode: googlePayPaymentData.paymentMethodData.info.billingAddress.countryCode.toUpperCase()
    };

    if (typeof paymentMethodsPage == 'undefined' && typeof addPaymentMethodsPage == 'undefined') {
        payloadCopy.details.firstName = googlePayPaymentData.shippingAddress.name;
        // payloadCopy.details.lastName = shippingContact.familyName;

        payloadCopy.details.shippingAddress = {
            line1: googlePayPaymentData.shippingAddress.address1,
            line2: googlePayPaymentData.shippingAddress.address2,
            city: googlePayPaymentData.shippingAddress.locality,
            state: googlePayPaymentData.shippingAddress.administrativeArea.toUpperCase(),
            postalCode: googlePayPaymentData.shippingAddress.postalCode,
            countryCode: googlePayPaymentData.shippingAddress.countryCode.toUpperCase()
        };
    }

    return payloadCopy;
}