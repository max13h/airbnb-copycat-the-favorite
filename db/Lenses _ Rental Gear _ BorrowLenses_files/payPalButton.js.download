function createPayPalPaymentMarkFlow(paypalOptions) {
    var payPalButtonConfigObj = eval("({" + payPalButtonConfig.replace('\"', '"') + "})");
    if (checkIntentOption(paypalIntent) === false) {
        var globalErrorsComponent = $(CONST.MARK_PAYPAL_BUTTON);
        globalErrorsComponent.empty();
        globalErrorsComponent.append(createErrorDiv(ACC.addons.braintreeaddon['braintree.message.incorect.intent']));
        $('.page-loader-new-layout').hide();

    } else {
        if ($(CONST.MARK_PAYPAL_BUTTON).is(":empty")) 
		{
			braintree.client.create(
			{
				authorization: clientToken
			},
			function (clientErr, clientInstance)
			{
				braintree.dataCollector.create({
				client: clientInstance,
				}, function (err, dataCollectorInstance) {
					if (err) 
					{
					var trackError= ACC.payPalError.paypalPaymentFail;
            window.mediator.publish('applyPayPal', {
            	paymentError: trackError
           	});
						// Handle error
						$('#payPalErrorMessage').empty();
						var payPalErrorMessage = $('<div class="notification notification-error mb-4 paypalNotification" />').text(ACC.payPalError.paypalPaymentFail);

						$('#payPalErrorMessage').append(payPalErrorMessage);
						$('.page-loader-new-layout').hide();
						console.log('Error while getting data collection for device');
						return;
					}
					// At this point, you should access the dataCollectorInstance.deviceData value and provide it
					// to your server, e.g. by injecting it into your form as a hidden input
					paypalDeviceData = dataCollectorInstance.deviceData;
				});
				braintree.paypalCheckout.create(
				{
					client: clientInstance
				}, 
				function (paypalCheckoutErr, paypalCheckoutInstance) 
				{
					let commit = paypalIntent === CONST.INTENT_SALE && userAction === 'true';
					try{
						loadSDK(paypalCheckoutInstance, paypalIntent, commit, paypalOptions.flow, 
						function () 
						{
							console.log("PayPal Sdk was loaded");
							payPalCheckoutRenderButton(paypalCheckoutInstance, CONST.MARK_PAYPAL_BUTTON, paypalOptions, commit, payPalButtonConfigObj);
						})
					}
					catch(error)
					{
						$('#payPalErrorMessage').empty();
						var payPalErrorMessage = $('<div class="notification notification-error mb-4 paypalNotification" />').text(ACC.payPalError.paypalPaymentFail);
						$('#payPalErrorMessage').append(payPalErrorMessage);
						$('.page-loader-new-layout').hide();
						console.log("Error while initiating paypal button : " + error);
						handlePayPalButtonError(err.message);
					}
					
				});
			});			
        }
		
    }
}

function createPayPalExpressCheckout(paypalOptions, payPalButtonContainer) {
    if ($(payPalButtonContainer).length > 0) {
        var payPalButtonConfigObj = eval("({" + payPalButtonConfig.replace('\"', '"') + "})");
        let commit = paypalIntent === CONST.INTENT_SALE && userAction === 'true';
        var isIntentValid = checkIntentOption(paypalIntent);
        if (isIntentValid === false) {
            var payPalErrorComponent = $(CONST.PAYPAL_EXPRESS_ERROR_ID);
            payPalErrorComponent.empty();
            payPalErrorComponent.append(createErrorDiv(ACC.addons.braintreeaddon['braintree.message.incorect.intent']));
            return;
        }

        braintree.paypalCheckout.create({
            client: client
        }, function (paypalCheckoutErr, paypalCheckoutInstance) {
            if (typeof paypal === 'undefined') {
                loadSDK(paypalCheckoutInstance, paypalIntent, commit, paypalOptions.flow, function () {
                    console.log("PayPal Sdk was loaded");
                    $(payPalButtonContainer).html('');
                    payPalCheckoutRenderButton(paypalCheckoutInstance, payPalButtonContainer, paypalOptions, commit, payPalButtonConfigObj);
                });
            }
            else {
                payPalCheckoutRenderButton(paypalCheckoutInstance, payPalButtonContainer, paypalOptions, commit, payPalButtonConfigObj);
            }
        });
    }

}

function payPalCheckoutRenderButton(paypalCheckoutInstance, payPalButtonContainer, paypalOptions, commit, payPalButtonStyle) {
    let isCheckoutFlow = getPaypalFlow().localeCompare(CONST.CHECKOUT_FLOW);
    if (isCheckoutFlow === 0) {
        if (creditEnabled && getStoreInVault()) {
            renderCheckoutBillingButtons(paypalCheckoutInstance, payPalButtonContainer, paypalOptions, commit, payPalButtonStyle);
        }
        else {
            renderCheckoutFlowPayPalButtons(paypalCheckoutInstance, payPalButtonContainer, paypalOptions, commit, payPalButtonStyle);
        }
    }
    else {
        renderVaultFlowPayPalButtons(paypalCheckoutInstance, payPalButtonContainer, paypalOptions, commit, payPalButtonStyle);
    }
}

function renderCheckoutFlowPayPalButtons(paypalCheckoutInstance, payPalButtonContainer, paypalOptions, commit, payPalButtonStyle){
    try {
        paypal.Buttons({
            style: payPalButtonStyle,
            locale: braintreeLocale,
            commit: commit,
            createOrder: function () {
                return paypalCheckoutInstance.createPayment(paypalOptions);
            },
            onApprove: function (data) {
                data.intent = paypalIntent;
                return paypalCheckoutInstance.tokenizePayment(data).then(function (payload) {
                    processExpressCheckoutForm(payload, false);
                });
            },
            onCancel: function () {
                console.log('User cancel PayPal flow');
            },

            onError: function (err) {
                console.error('Error: ' + err, err);
                handlePayPalClientError(err);
            }
        }).render(payPalButtonContainer);
    }
    catch (err) {
        handlePayPalButtonError(err.message);
    }
}

function renderVaultFlowPayPalButtons(paypalCheckoutInstance, payPalButtonContainer, paypalOptions, commit, payPalButtonStyle){
    try {
        paypal.Buttons({
            style: payPalButtonStyle,
            locale: braintreeLocale,
            commit: commit,
            createBillingAgreement: function () {
            	$('#payPalErrorMessage').empty();
                return paypalCheckoutInstance.createPayment(paypalOptions);
            },
            onApprove: function (data) {
                return paypalCheckoutInstance.tokenizePayment(data).then(function (payload) {
                    processExpressCheckoutForm(payload, typeof payPalShouldBeSaved !== "undefined" ? payPalShouldBeSaved : false);
                    $('#payPalErrorMessage').empty();
                });
            },
            onCancel: function (data) {
                console.log('User cancel PayPal flow');
            },
            onError: function (err) {
                console.error('Error: ' + err, err);
                $('#payPalErrorMessage').empty();
                var payPalErrorMessage = $('<div class="notification notification-error mb-4 paypalNotification" />').text(ACC.payPalError.paypalPaymentFail);
	  			$('#payPalErrorMessage').append(payPalErrorMessage);
                handlePayPalClientError(err);
            }
        }).render(payPalButtonContainer).then(function(){
        	$('.page-loader-new-layout').hide();
        });
    }
    catch (err) {
    	$('#payPalErrorMessage').empty();
    	var payPalErrorMessage = $('<div class="notification notification-error mb-4 paypalNotification" />').text(ACC.payPalError.paypalPaymentFail);
	  	$('#payPalErrorMessage').append(payPalErrorMessage);
		$('.page-loader-new-layout').hide();
		console.log("Error while rendering paypal button");
        handlePayPalButtonError(err.message);        
    }
}

function renderCheckoutBillingButtons(paypalCheckoutInstance, payPalButtonContainer, paypalOptions, commit, payPalButtonStyle){
    try {
        paypal.Buttons({
            style: payPalButtonStyle,
            locale: braintreeLocale,
            commit: commit,
            createOrder: function () {
                return paypalCheckoutInstance.createPayment(paypalOptions);
            },
            onApprove: function (data) {
                return paypalCheckoutInstance.tokenizePayment(data).then(function (payload) {
                    processExpressCheckoutForm(payload, typeof payPalShouldBeSaved !== "undefined" ? payPalShouldBeSaved : false);
                });
            },
            onCancel: function (data) {
                console.log('User cancel PayPal flow');
            },

            onError: function (err) {
                console.error('Error: ' + err, err);
                handlePayPalClientError(err);
            }
        }).render(payPalButtonContainer);
    }
    catch (err) {
        handlePayPalButtonError(err.message);
    }
}


function handlePayPalClientError(error) {
    if (typeof error != 'undefined' || error != 'undefined') {
        // skip validation error: use paypal method
        if ('User did not enter a payment method' != error.message && 'PAYPAL_POPUP_CLOSED' != error.code) {
            $('#paypal_express_error').empty();
            var messageText = error.message;
            if (typeof messageText === 'undefined' || messageText === 'undefined') {
                //Undefined error
            } else {
                var errorMsg = (typeof getErrorMessage(error.code) === "undefined")
                    ? ACC.addons.braintreeaddon['braintree.message.error.provider'] + ' ' + messageText : getErrorMessage(error.code);
                $(CONST.GLOBAL_MESSAGES).empty();
                $(CONST.GLOBAL_MESSAGES).append(createErrorDiv(createErrorDiv(errorMsg)));
            }
        }
    }
}

function handlePayPalButtonError(errorMsg) {
    if (typeof errorMsg != 'undefined' || errorMsg != 'undefined') {
        if (typeof paymentMethodsPage != "undefined") {
            $(CONST.PAYPAL_BUTTON_MESSAGE).empty();
            $(CONST.PAYPAL_BUTTON_MESSAGE).append(createErrorDiv(createErrorDiv(errorMsg)));
        }
        $('#paypal_express_error').empty();
        $(CONST.PAYPAL_EXPRESS_ERROR_ID).empty();
        $(CONST.PAYPAL_EXPRESS_ERROR_ID).append(createErrorDiv(errorMsg));
    }
}
