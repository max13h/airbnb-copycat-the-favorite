function configureAccountPaymentInfoPage(){
    if (typeof braintree == 'undefined' || braintree == '' || typeof google == 'undefined') {
        addBrainTreeLibrary(function () {
            createClientInstance(CONST.GLOBAL_MESSAGES, function(){
                checkVenmoPaymentMethods();
                initialiseGooglePay();
            })
        });
    } else {
        checkVenmoPaymentMethods();
        initialiseGooglePay();
    }
}