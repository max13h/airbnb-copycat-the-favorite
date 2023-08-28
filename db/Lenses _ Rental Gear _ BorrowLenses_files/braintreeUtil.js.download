function addBrainTreeLibrary(onBrainTreeLibraryLoaded) {
    var before = Date.now();
    var loadedScripts = 0;
    for (var i = 0; i < CONST.BT_LIBS.length; i++) {
        console.log("Loading library: " + CONST.BT_LIBS[i] + ", now: " + Date.now());
        $.getScript(CONST.BT_LIBS[i])
            .done(function (script, textStatus) {
                loadedScripts++;
                console.log("Done, status: " + textStatus + ", took: " + (Date.now() - before) + ", now: " + Date.now() + ", loadedScripts: " + loadedScripts);

                if (loadedScripts == CONST.BT_LIBS.length) {
                    onBrainTreeLibraryLoaded();
                }
            })
            .fail(function (jqxhr, settings, exception) {
                console.error("Fail, exception: " + exception + ", took: " + (Date.now() - before) + ", now: " + Date.now());
            });
    }

    var after = Date.now();
    console.log("Queueing Load libraries took, ms: " + (after - before));
}

function loadSDK(paypalCheckoutInstance, paypalIntent, commit, flow, onLoad) {
    paypalCheckoutInstance.getClientId().then(function (id) {
        let vault = flow === CONST.VAULT_FLOW;
        var importRequest = {};
        var disableFunding = !creditEnabled ? "credit" : "";
        importRequest["client-id"] = id;
        importRequest.commit = commit;
        importRequest.intent = paypalIntent === "sale" || vault ? "capture" : paypalIntent;
        importRequest.components = "buttons,messages";

        if (vault){
            importRequest.vault = vault;
        }
        if (typeof disableMarkFunding === 'undefined') {
            disableFunding += disableFunding !== "" ? ",card": "card";
        }
        else if (disableMarkFunding !== "") {
            disableFunding += disableFunding !== "" ? "," + disableMarkFunding : disableFunding;
        }
        if (disableFunding !== ""){
            importRequest["disable-funding"] = disableFunding;
        }
        if (typeof currency !== 'undefined' && currency !== '') {
            importRequest.currency = currency;
        }
        if (typeof braintreeLocale != 'undefined' && braintreeLocale !== '') {
            importRequest.locale = braintreeLocale;
        }

        paypalCheckoutInstance.loadPayPalSDK(importRequest, function () {
            onLoad();
        });
    });
}

function createClientInstance(errorDivId, onClientIstanceLoaded) {
    if ((typeof clientToken != 'undefined' && clientToken != '')
        && (typeof braintree != 'undefined' && braintree != '')) {
        braintree.client.create({
            authorization: clientToken
        }, function (clientErr, clientInstance) {
            if (clientErr) {
                handleClientError(clientErr);
                return;
            }

            if (typeof advancedFraudToolsEnabled != 'undefined'){
                createDataCollector({
                    client: clientInstance,
                    paypal: JSON.parse(advancedFraudToolsEnabled)
                })
            }

            client = clientInstance;
            onClientIstanceLoaded();
        });
    } else {
        var errorsComponent = $(errorDivId);
        errorsComponent.empty();
        if (errorDivId === CONST.GLOBAL_MESSAGES){
            errorsComponent.append(createErrorDiv(ACC.addons.braintreeaddon['braintree.message.use.saved.payments']));
        } else if (errorDivId === CONST.PAYPAL_EXPRESS_ERROR_ID) {
            errorsComponent.append(createErrorDiv(ACC.addons.braintreeaddon['braintree.message.try.refresh']));
        }
    }
}


function handleClientError(error) {
    if (typeof error != 'undefined' || error != 'undefined') {
        // skip validation error: use paypal method
        if ('User did not enter a payment method' != error.message) {
            var errorMsg = (typeof getErrorMessage(error.code) === "undefined")
                ? ACC.addons.braintreeaddon['braintree.message.error.provider'] + ' ' + error.message : getErrorMessage(error.code);
            $(CONST.GLOBAL_MESSAGES).empty();
            $(CONST.GLOBAL_MESSAGES).append(createErrorDiv(createErrorDiv(errorMsg)));
        }
    }
}

function createDataCollector(configObj) {
    braintree.dataCollector.create(configObj, function (error, dataCollectorInstance) {
        if (error) {
            handleClientError(error);
            return;
        } else {
            deviceData = dataCollectorInstance.deviceData;
        }
    });
}

function getPaypalFlow() {
    if (paypalIntent == CONST.INTENT_ORDER) {
        storeInVault = 'false';
    }
    if (getStoreInVault() && !creditEnabled) {
        return CONST.VAULT_FLOW;
    }
    return CONST.CHECKOUT_FLOW;
}

function getStoreInVault() {
    return storeInVault != '' && storeInVault != undefined && (storeInVault == CONST.ON_SUCCESS || storeInVault == CONST.TRUE);
}

function createErrorDiv(message) {
    var errorComponent = $(HTML.DIV).attr(HTML.CLASS, CONST.ERROR_ALERT_NEGATIVE_CSS_CLASS);
    errorComponent.prepend(message);
    return errorComponent;
}

function resetHostedFields() {
    $(CONST.NUMBER_ID).empty();
    $(CONST.EXPIRATION_YEAR_ID).empty();
    $(CONST.EXPIRATION_MONTH_ID).empty();
    $(CONST.CVV_ID).empty();
    $(CONST.CARD_HOLDER_ID).empty();
}
