
function createLocalPayment() {
    // Create a local payment component.
    return braintree.localPayment.create({
        client: client,
        merchantAccountId: currencyMerchantAccountId
    }).then(function (localPaymentInstance) {

        function createLocalPaymentClickListener(type) {
            return function (event) {
                event.preventDefault();
                localPaymentInstance.startPayment({
                    paymentType: type,
                    amount: amount,
                    fallback: {
                        url: endpointURL + '/braintree/checkout/lpm/fallback',
                        buttonText: 'Complete Payment',
                    },
                    currencyCode: currency,
                    shippingAddressRequired: false,
                    onPaymentStart: function (data, start) {
                        // NOTE: It is critical here to store data.paymentId on your server
                        //       so it can be mapped to a webhook sent by Braintree once the
                        //       buyer completes their payment. See Start the payment
                        //       section for details.
                        var processUrl = ACC.config.encodedContextPath + '/braintree/checkout/lpm/savePayment';
                        var params = {
                            "paymentId": data.paymentId
                        };
                        return $.post(processUrl, params).then(function (res) {
                            start();
                        });
                    }
                }, function (startPaymentError, payload) {
                    if (startPaymentError) {
                        if (startPaymentError.code === 'LOCAL_PAYMENT_POPUP_CLOSED') {
                            console.error('Customer closed Local Payment popup.');
                        } else {
                            console.error('Error!', startPaymentError);
                        }
                    } else {
                        // Send the nonce to your server to create a transaction
                        processLocalPaymentMethod(payload);
                    }
                });
            };
        }

        lpmids.forEach(function (lpm) {
            document.getElementById(lpm).addEventListener('click', createLocalPaymentClickListener(lpm))
        });
    });
}


function processLocalPaymentMethod(response) {

            var submitForm = createForm(CONST.PAYPAL_EXPRESS_FORM_NAME, ACC.config.encodedContextPath + "/braintree/checkout/lpm/process");

            var paymentNonce = createHiddenParameter(CONST.PAYMENT_METHOD_NONCE, response.nonce);
            var payerEmail = createHiddenParameter(CONST.PAYER_EMAIL, response.details.email);
            // collect device data for advanced fraud tools
            var deviceData = createHiddenParameter(CONST.DEVICE_DATA, response.correlationId);
            var cardholder = createHiddenParameter(CONST.CARDHOLDER, $(CONST.CARD_HOLDER_ID).val());

            var token = ACC.config.CSRFToken;
            var realToken = createHiddenParameter("CSRFToken", token);
            submitForm.append($(paymentNonce));
            submitForm.append($(payerEmail));
            submitForm.append($(deviceData));
            submitForm.append($(cardholder));
            submitForm.append($(realToken));
            submitForm.appendTo('body');
            submitForm.submit()
        }