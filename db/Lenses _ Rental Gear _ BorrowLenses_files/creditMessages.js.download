
function configurePageForCreditMessage() {
    if (typeof braintree == 'undefined' || braintree == '') {
        addBrainTreeLibrary(function () {
            initialiseCreditMessage();
        });
    } else {
        initialiseCreditMessage();
    }
}

function initialiseCreditMessage() {
    if (typeof braintree != 'undefined' && braintree != '') {
        createClientInstance(CONST.PAYPAL_EXPRESS_ERROR_ID, function () {
            braintree.paypalCheckout.create({
                client: client
            }, function (paypalCheckoutErr, paypalCheckoutInstance) {
                if (typeof paypal === "undefined") {
                    let commit = paypalIntent === CONST.INTENT_SALE && userAction === 'true';
                    loadSDK(paypalCheckoutInstance, paypalIntent, commit, getPaypalFlow(), function(){
                        console.log("PayPal Sdk was loaded");
                    });
                }
            });
        });
    }
}