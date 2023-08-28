function createApplePay(options, buttonSelector, processResponseCallback) {
    braintree.applePay.create({
        client: client
    }, function (applePayErr, applePayInstance) {
        if (applePayErr) {
            console.error('Error creating applePayInstance:', applePayErr);
            return;
        }
        var createApplePaySession = function () {
            if (typeof paymentMethodsPage != 'undefined') {
                var paymentRequest = applePayInstance.createPaymentRequest({
                    total: {
                        label: options.flow,
                        amount: amount
                    },
                    requiredShippingContactFields: ['email']
                });
            } else {
                var paymentRequest = applePayInstance.createPaymentRequest({
                    requiredBillingContactFields: ['postalAddress', 'name'],
                    requiredShippingContactFields: ['postalAddress', 'name', 'phone', 'email'],
                    total: {
                        label: options.flow,
                        amount: amount
                    }
                });
            }

            var session = new ApplePaySession(1, paymentRequest);

            session.onvalidatemerchant = function (event) {
                applePayInstance.performValidation({
                    validationURL: event.validationURL,
                    displayName: "Electronics"
                }, function (error, merchantSession) {
                    if (error) {
                        // Handle errors
                        console.error(error);
                        session.abort();
                        return;
                    }
                    session.completeMerchantValidation(merchantSession);
                });
            };
            session.onpaymentauthorized = function (event) {

                applePayInstance.tokenize({
                    token: event.payment.token
                }, function (error, payload) {
                    if (error) {
                        // Handle errors
                        console.error(error);
                        session.completePayment(ApplePaySession.STATUS_FAILURE);
                        return;
                    }

                    var shippingContact = event.payment.shippingContact;
                    var billingContact = event.payment.billingContact;

                    session.completePayment(ApplePaySession.STATUS_SUCCESS);

                    var payloadCopy = {};
                    payloadCopy.nonce = payload.nonce;
                    payloadCopy.details = {};
                    payloadCopy.type = payload.type;
                    payloadCopy.details.email = shippingContact.emailAddress;

                    if (typeof paymentMethodsPage == 'undefined') {
                        payloadCopy.details.firstName = shippingContact.givenName;
                        payloadCopy.details.lastName = shippingContact.familyName;
                        payloadCopy.details.phone = shippingContact.phoneNumber;


                        payloadCopy.details.billingAddress = {
                            line1: billingContact.addressLines[0],
                            line2: billingContact.addressLines[1],
                            city: billingContact.locality,
                            state: billingContact.administrativeArea.toUpperCase(),
                            postalCode: billingContact.postalCode,
                            countryCode: billingContact.countryCode.toUpperCase()
                        };

                        payloadCopy.details.shippingAddress = {
                            line1: shippingContact.addressLines[0],
                            line2: shippingContact.addressLines[1],
                            city: shippingContact.locality,
                            state: shippingContact.administrativeArea.toUpperCase(),
                            postalCode: shippingContact.postalCode,
                            countryCode: shippingContact.countryCode.toUpperCase()
                        };
                    }

                    processResponseCallback(payloadCopy);

                });
            };
            session.begin();
        };

        var promise = ApplePaySession.canMakePaymentsWithActiveCard(applePayInstance.merchantIdentifier);
        promise.then(function (canMakePaymentsWithActiveCard) {
            if (!canMakePaymentsWithActiveCard) {
                disableApplePay();
                createApplePaySession = null;
                return;
            } else {
                enableApplePay();
            }
        });

        $(buttonSelector).unbind(EVENTS.CLICK);
        $(buttonSelector).click(function () {
            if (createApplePaySession != null) {
                createApplePaySession();
            }
        });
    });
}

function processApplePayResponse(payload) {
    var email = payload.details.email;
    if (payload.nonce != null) {
        $(CONST.PAYPAL_IS_VALID_ID).val("true");
        var errorComponent = $(HTML.DIV).attr(HTML.CLASS, CONST.ALERT_POSITIVE_BT_VALIDATION_CSS_CLASS);
        errorComponent.prepend(ACC.addons.braintreeaddon['braintree.message.paypal.error'] + email);

        $(CONST.GLOBAL_MESSAGES).append(errorComponent);
        $(CONST.PAYPAL_EMAIL_ID).val(email);
    }
    $(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).unbind(EVENTS.CLICK);
    $(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).trigger(EVENTS.CLICK, [true]);
    processResponce(payload);
}

function processApplePayResponseExpressCheckout(response) {
    processExpressCheckoutForm(response, false);
}

function showApplePay() {
    $(CONST.APPLE_PAY_BUTTON_CONTAINER).removeClass(CONST.HIDE);
}

function disableApplePay() {
    showApplePay();
    $(CONST.APPLE_PAY_BUTTON_SELECTOR).addClass("disabled-button");
    $(CONST.APPLE_PAY_BUTTON_SELECTOR).unbind('click');
}

function enableApplePay() {
    showApplePay();
    $(CONST.APPLE_PAY_BUTTON_SELECTOR).removeClass("disabled-button");
}

function removeApplePay() {
    $(CONST.APPLE_PAY_BUTTON_CONTAINER).remove();
    $(CONST.APPLEPAY_SELECTOR).remove();
}

function isAvailableApplePay() {
    return typeof window.ApplePaySession != "undefined" && ApplePaySession.canMakePayments();
}