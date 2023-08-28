//
//function createHostedFields() {
//    braintree.hostedFields.create({
//            client: client,
//            styles: {
//                // Styling element state
//                ":focus": {
//                    "color": "blue"
//                },
//                ".valid": {
//                    "color": "green"
//                },
//                ".invalid": {
//                    "color": "red"
//                }
//            },
//            fields: {
//                number: {
//                    selector: CONST.NUMBER_ID
//                },
//                expirationDate: {
//                    selector: CONST.EXPIRATION_DATE_ID,
//                    placeholder: "MM/YY"
//                },
//                cvv: {
//                    selector: CONST.CVV_ID
//                }
//            }
//        },
//        function (hostedFieldsErr, hostedFieldsInstance) {
//            if (hostedFieldsErr) {
//                handleClientError(hostedFieldsErr);
//                return;
//            }
//
//            $(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).unbind(EVENTS.CLICK);
//            // Add a click event listener to PayPal image
//            $(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).click(function () {
//                // initialize paypal authorization
//                hostedFieldsInstance.tokenize(function (tokenizeErr, payload) {
//                    if (tokenizeErr) {
//                        handleClientError(tokenizeErr)
//                    } else {
//                        if ((typeof secure3d != 'undefined' && JSON.parse(secure3d)) && ("CreditCard" == payload.type)) {
//                            verify3DSecure(client, payload);
//                        } else {
//                            processResponce(payload);
//                        }
//                    }
//                });
//            });
//        }
//    );
//}
//
//function initialise3dSecure(e){
//    e.preventDefault();
//    var value = $(document).find('input[name="selectedPaymentMethodNonce"]').val();
//    var paymentMethod = $(document).find('input[name="selectedPaymentMethod"]').val();
//    if (!$.parseJSON(secure3d) || paymentMethod === "PayPal") {
//        e.currentTarget.submit();
//    }
//    braintree.client.create({
//        authorization: clientToken
//    }, function (clientErr, clientInstance) {
//        if (clientErr) {
//            handleClientError(clientErr);
//            return;
//        }
//        braintree.threeDSecure.create({
//            version: 2,
//            client: clientInstance
//        }, function (err, threeDSecure) {
//            threeDSecure.verifyCard({
//                onLookupComplete: function (data, next) {
//                    console.log(JSON.stringify(data));
//                    next();
//                },
//                amount: amount,
//                nonce: value,
//                addFrame: function (err, iframe) {
//                    threeDSContainer = $(HTML.DIV);
//                    $(threeDSContainer).append(iframe);
//                    ACC.colorbox.open("", {
//                        inline: true,
//                        href: threeDSContainer,
//                        onComplete: function () {
//                            $(this).colorbox.resize();
//                        }
//                    });
//                },
//                removeFrame: function () {
//                    ACC.colorbox.close();
//                }
//            }, function (error, response) {
//                if (error) {
//                    show3DSecureMessage(error);
//                    return;
//                } else {
//                    // 3DSecure finished, add 3DSecure returned nonce
//                    var liabilityShifted = response.liabilityShifted;
//                    $(document).find('input[name="selectedPaymentMethodNonce"]').val(response.nonce);
//                    // allow process card if 3dSecureLiabilityResult is skipped by merchant
//                    if (liabilityShifted || JSON.parse(skip3dSecureLiabilityResult)) {
//                        e.currentTarget.submit();
//                    } else {
//                        show3DSecureMessage(ACC.addons.braintreeaddon['braintree.message.unsecured.card']);
//                    }
//                }
//            });
//        });
//    });
//    return false;
//}
//
//function verify3DSecure(clientInstance, paymentResponse) {
//    configurePayPalAlongWithHostedFields();
//    // selectPaymentMethod();
//    braintree.threeDSecure.create({
//        version: 2,
//        client: clientInstance
//    }, function (err, threeDSecure) {
//        threeDSecure.verifyCard({
//            onLookupComplete: function (data, next) {
//                next();
//            },
//            amount: amount,
//            nonce: paymentResponse.nonce,
//            addFrame: function (err, iframe) {
//                threeDSContainer = $(HTML.DIV);
//                $(threeDSContainer).append(iframe);
//                ACC.colorbox.open("", {
//                    inline: true,
//                    href: threeDSContainer,
//                    onComplete: function () {
//                        $(this).colorbox.resize();
//                    }
//                });
//            },
//            removeFrame: function () {
//                ACC.colorbox.close();
//            }
//        }, function (error, response) {
//            if (error) {
//                show3DSecureMessage(error);
//                return;
//            } else {
//                // 3DSecure finished
//                // add 3DSecure returned nonce
//                paymentResponse.nonce = response.nonce;
//                var liabilityShifted = response.liabilityShifted;
//                // allow process card if 3dSecureLiabilityResult is
//                // skipped by merchant
//                if (liabilityShifted || JSON.parse(skip3dSecureLiabilityResult)) {
//                    paymentResponse.liabilityShifted = liabilityShifted;
//                    processResponce(paymentResponse);
//                } else {
//                    show3DSecureMessage(ACC.addons.braintreeaddon['braintree.message.unsecured.card']);
//                }
//            }
//        });
//    });
//}
//
//function show3DSecureMessage(message) {
//    $(CONST.GLOBAL_MESSAGES).children(CONST.VALIDATION_CLASS).remove();
//    var errorComponent = CONST.ERROR_DIV + message + HTML.DIV;
//    $(CONST.GLOBAL_MESSAGES).append(errorComponent);
//}