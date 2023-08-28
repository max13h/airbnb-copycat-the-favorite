function renderVenmoButton() {
    var venmoButton = document.getElementById('venmo-button');
    $(CONST.VENMO_BUTTON).removeClass(CONST.HIDE);
    var profileId;
    if (typeof venmoProfileId !== 'undefined') {
        profileId = venmoProfileId;
    }

    braintree.venmo.create({
        client: client,
        profileId: profileId,
    }, function (venmoErr, venmoInstance) {
        if (venmoErr) {
            console.error('Error creating Venmo:', venmoErr);
            return;
        }

        if (!venmoInstance.isBrowserSupported()) {
            console.log('Browser does not support Venmo');
            return;
        }

        displayVenmoButton(venmoInstance);

        if (venmoInstance.hasTokenizationResult()) {
                venmoInstance.tokenize().then(handleVenmoSuccess).catch(handleVenmoError);
            }

    });



    function displayVenmoButton(venmoInstance) {
        venmoButton.style.display = 'block';

        venmoButton.addEventListener('click', function () {
            venmoButton.disabled = true;

            venmoInstance.tokenize(function (tokenizeErr, payload) {
                venmoButton.removeAttribute('disabled');
                if (tokenizeErr) {
                    handleVenmoError(tokenizeErr);
                } else {
                    handleVenmoSuccess(payload);
                }
            });
        });
    }

    function handleVenmoError(err) {
        if (err.code === 'VENMO_CANCELED') {
            console.log('App is not available or user aborted payment flow');
        } else if (err.code === 'VENMO_APP_CANCELED') {
            console.log('User canceled payment flow');
        } else {
            console.error('An error occurred:', err.message);
        }
    }


    function handleVenmoSuccess(payload) {
        processVenmoResponse(payload, false);
        console.log('Got a payment method nonce:', payload.nonce);
        // Display the Venmo username in your checkout UI.
        console.log('Venmo user:', payload.details.username);
    }
}

function processVenmoResponse(response, forceVault) {
    var submitForm;
    var isSavePaymentInfo;
    var token = ACC.config.CSRFToken;
    var realToken = createHiddenParameter("CSRFToken", token);
    var collectDeviceData = createHiddenParameter(CONST.DEVICE_DATA, deviceData);

    if (typeof addPaymentMethodsPage != 'undefined') {
        submitForm = createForm(CONST.VENMO_PAYMENT_FORM_NAME, ACC.config.encodedContextPath + "/braintree/paypal/checkout/add-payment-method");
        var paymentType = createHiddenParameter("payPalData", JSON.stringify(response));
        var selectedAddressCode = createHiddenParameter("selectedAddressCode", deliveryAddressId);
        submitForm.append($(selectedAddressCode));
        submitForm.append($(paymentType));
    } else {
        submitForm = createForm(CONST.VENMO_PAYMENT_FORM_NAME, ACC.config.encodedContextPath + "/braintree/checkout/venmo/process");
        var paymentNonce = createHiddenParameter(CONST.PAYMENT_METHOD_NONCE, response.nonce);
        var userName = createHiddenParameter("username", response.details.username);
        submitForm.append($(paymentNonce));
        submitForm.append($(userName));
    }

    if ($(CONST.SAVE_PAYMENT_INFO_ID + ':' + CONST.PROP_CHECKED).val() === CONST.TRUE || forceVault === true) {
        isSavePaymentInfo = createHiddenParameter("isSaved", CONST.TRUE);
    } else {
        isSavePaymentInfo = createHiddenParameter("isSaved", CONST.FALSE);
    }
    submitForm.append($(isSavePaymentInfo));
    submitForm.append($(collectDeviceData));
    submitForm.append($(realToken));
    submitForm.appendTo('body');
    submitForm.submit();
}

function isAvailableVenmo() {
    return venmoEnabled && braintree.venmo.isBrowserSupported();
}


function checkVenmoPaymentMethods() {
    checkSavedPaymentMethods(CONST.VENMO_ACCOUNT, isAvailableVenmo());
}