function configurePaypalShortcut(payPalButtonClass) {

    if (typeof braintree == 'undefined' || braintree == '') {
        addBrainTreeLibrary(function () {
            createClientInstance(CONST.PAYPAL_EXPRESS_ERROR_ID, function () {
                initialisePaypal(payPalButtonClass);
                initialiseGooglePay();
                initialiseApplePay();
            });
        });
    } else {
        createClientInstance(CONST.PAYPAL_EXPRESS_ERROR_ID, function (){
            initialisePaypal(payPalButtonClass);
            initialiseGooglePay();
            initialiseApplePay();
        })
    }
}


function initialisePaypal(payPalButtonClass) {
    createPayPalExpressCheckout(createPayPalOtionsExpressCheckout(), payPalButtonClass);
}

function initialiseApplePay() {
    if (isAvailableApplePay() && applePayEnabled) {
        disableApplePay();
        createApplePay(createPayPalOtionsExpressCheckout(), CONST.APPLE_PAY_BUTTON_SELECTOR, function (payload) {
            processApplePayResponseExpressCheckout(payload);
        });
    } else {
        $(CONST.APPLE_PAY_BUTTON_CONTAINER).remove();
    }
}

function createPayPalOtionsExpressCheckout() {
    let paypalFlow = getPaypalFlow();

    var paypalOptions = {
        flow: paypalFlow,
        enableShippingAddress: JSON.parse(enableShippingAddress),
        enableBillingAddress: true,
        locale: braintreeLocale,
    };

    if (paypalFlow == CONST.CHECKOUT_FLOW) {
        // configure paypal integration
        if (paypalIntent != undefined && paypalIntent !== "") {
            paypalOptions.intent = paypalIntent;
        }
        paypalOptions.amount = amount;
        paypalOptions.currency = currency;
        //configure pay later integration
        if (creditEnabled && getStoreInVault()) {
            paypalOptions.requestBillingAgreement = true;
            paypalOptions.billingAgreementDetails = {
                description: billingAgreementDescription
            }
        }

    }
    else if (paypalFlow == CONST.VAULT_FLOW) {
        paypalOptions.billingAgreementDescription = billingAgreementDescription;
    }

    // configure display name for paypal connection
    if (typeof dbaName != 'undefined' && dbaName != '') {
        if (dbaName.indexOf('*') > -1) {
            paypalOptions.displayName = dbaName.substr(0, dbaName.indexOf('*'));
        }
    }
    return paypalOptions;
}