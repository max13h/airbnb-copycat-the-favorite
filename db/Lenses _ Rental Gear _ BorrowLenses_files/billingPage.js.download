function createPayPalOptions() {

    var paypalOptions;

    // reset hosted fields in case repeated initialization
    resetHostedFields();

    var paypalFlow = getPaypalFlow();

    var enableShippingAddressValue = JSON.parse(enableShippingAddress);

    var paypalOptions = {
        flow: paypalFlow,
        enableShippingAddress: enableShippingAddressValue,
        enableBillingAddress: true,
        locale: braintreeLocale,
        shippingAddressEditable: false
    };

    //add payment method page
    if ((typeof addPaymentMethodsPage != 'undefined')) {
        paypalOptions.billingAgreementDescription = billingAgreementDescription;
    } else {
        // configure paypal connections
        if (paypalFlow == CONST.CHECKOUT_FLOW) {
            if (paypalIntent != undefined && paypalIntent !== "") {
                paypalOptions.intent = paypalIntent;
            }
            paypalOptions.amount = amount;
            if (typeof currency !== 'undefined') {
                paypalOptions.currency = currency;
            }
            if (enableShippingAddressValue) {
                paypalOptions.shippingAddressOverride = {
                    recipientName: recipientName,
                    line1: streetAddress,
                    line2: extendedAddress,
                    city: locality,
                    countryCode: countryCodeAlpha2,
                    postalCode: postalCode,
                    state: region,
                    phone: phone
                }
            }
            if (creditEnabled && getStoreInVault()) {
                paypalOptions.requestBillingAgreement = true,
                paypalOptions.billingAgreementDetails = {
                    description: billingAgreementDescription
                }
            }
        } else if (paypalFlow == CONST.VAULT_FLOW) {
            if (paypalIntent != undefined && paypalIntent !== "") {
                paypalOptions.intent = paypalIntent;
            }
            paypalOptions.amount = amount;
            paypalOptions.currency = currency;
            if (enableShippingAddressValue) {
                paypalOptions.shippingAddressOverride = {
                    recipientName: recipientName,
                    line1: streetAddress,
                    line2: extendedAddress,
                    city: locality,
                    countryCode: countryCodeAlpha2,
                    postalCode: postalCode,
                    state: region,
                    phone: phone
                }
            }

            paypalOptions.billingAgreementDescription = billingAgreementDescription;       

            // configure display name for paypal connection
            if (typeof dbaName != 'undefined' && dbaName != '') {
                if (dbaName.indexOf('*') > -1) {
                    paypalOptions.displayName = dbaName.substr(0, dbaName.indexOf('*'));
                }
            }
        }
    }
    return paypalOptions;
}


