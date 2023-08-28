function checkIntentOption(paypalIntent) {
    var isIntentValid = true;
    if (paypalIntent != CONST.INTENT_SALE && paypalIntent != CONST.INTENT_ORDER
        && paypalIntent != CONST.INTENT_AUTHORIZE && paypalIntent != CONST.INTENT_CAPTURE) {
        isIntentValid = false;
        return isIntentValid;
    } else {
        return isIntentValid;
    }
}

function processExpressCheckoutForm(paypalResponse, forceVault) {
    var payPalForm;
    var isSavePaymentInfo;

    if ((typeof addPaymentMethodsPage != 'undefined')) {
        payPalForm = createForm(CONST.PAYPAL_EXPRESS_FORM_NAME, ACC.config.encodedContextPath + "/braintree/paypal/checkout/add-payment-method");
    } 
   else {
        payPalForm = createForm(CONST.PAYPAL_EXPRESS_FORM_NAME, ACC.config.encodedContextPath + "/braintree/paypal/checkout/express");
    }

    if($('#js-extend-order-page').val() == 'true'){
           payPalForm = createForm(CONST.PAYPAL_EXPRESS_FORM_NAME, ACC.config.encodedContextPath + "/braintree/paypal/checkout/extendOrder-payment");
    }
    
    if($('#js-modify-order-page').val() == 'true'){
        payPalForm = createForm(CONST.PAYPAL_EXPRESS_FORM_NAME, ACC.config.encodedContextPath + "/braintree/paypal/checkout/modify-payment-method");
 }

    if ($(CONST.SAVE_PAYMENT_INFO_ID + ':' + CONST.PROP_CHECKED).val() === CONST.TRUE || forceVault === true) {
        isSavePaymentInfo = createHiddenParameter("isSaved", CONST.TRUE);
    } else {
        isSavePaymentInfo = createHiddenParameter("isSaved", CONST.FALSE);
    }

    var paymentType = createHiddenParameter("payPalData", JSON.stringify(paypalResponse));
    var token = ACC.config.CSRFToken;
    var realToken = createHiddenParameter("CSRFToken", token);

    // collect device data for advanced fraud tools
    var collectDeviceData = createHiddenParameter("device_data", this.paypalDeviceData);

    var extendOrderCode = createHiddenParameter("extend_Order_Code", $("#js-extend-order-code").val());
    payPalForm.append($(extendOrderCode));
    var extendOrderPage = createHiddenParameter("extend_order_page", $("#js-extend-order-page").val());
    payPalForm.append($(extendOrderPage));
    var orderCode = createHiddenParameter("order_code", $("#orderCode").val());
    var amountToBePaid = '';
    var isDepositPaymentPage = false;
    var isModifyOrderPaymentPage = false;
    if($("#deposit-amount").length == 1)
    {
      amountToBePaid = $("#deposit-amount").val();
      isDepositPaymentPage = true;
    }
    else if($("#modify_order-payment-amount").length == 1)
    {
      amountToBePaid = $("#modify_order-payment-amount").val();
      isModifyOrderPaymentPage = true;
    }
    else
    {
      amountToBePaid = $("#payBillTotal").val();
    }
    var payBillTotal = createHiddenParameter("payBillTotal", amountToBePaid);
    var modifyOrderTotal = createHiddenParameter("modifyOrderTotal", $("#modifyOrderTotal").val());
    var isDeposit = createHiddenParameter("isDepositPaymentPage", isDepositPaymentPage);
    var isPaymentForModifyOrder = createHiddenParameter("isModifyOrderPaymentPage", isModifyOrderPaymentPage);
    
    payPalForm.append($(modifyOrderTotal));
    payPalForm.append($(payBillTotal));
    payPalForm.append($(orderCode));
	payPalForm.append($(isDeposit));
	payPalForm.append($(isPaymentForModifyOrder));
    payPalForm.append($(isSavePaymentInfo));
    payPalForm.append($(collectDeviceData));
    payPalForm.append($(paymentType));
    payPalForm.append($(realToken));
    payPalForm.appendTo('body');

    payPalForm.submit();
}

function processResponce(responce) {

    var submitForm = $('#' + CONST.BRAINTREE_PAYMENT_FORM_ID);

    var useDelivery = createHiddenParameter("use_delivery_address", $(CONST.USE_DELIVERY_ADDRESS_ID).is(HTML.CHECKED));
    var paymentType = createHiddenParameter(CONST.PAYMENT_TYPE, responce.type);
    var cardType = createHiddenParameter(CONST.CARD_TYPE, responce.details.cardType);
    var cardDetails = createHiddenParameter(CONST.CARD_DETAILS,
        responce.details.lastTwo);

    var isLiabilityShifted = '';

    var paymentNonce = createHiddenParameter(CONST.PAYMENT_METHOD_NONCE,
        responce.nonce);
    submitForm.append($(paymentNonce));
    if (typeof responce.liabilityShifted != 'undefined') {
        isLiabilityShifted = responce.liabilityShifted;
    }

    var liabilityShifted = createHiddenParameter(CONST.LIABILITY_SHIFTED,
        isLiabilityShifted);
    submitForm.append($(liabilityShifted));

    // collect device data for advanced fraud tools
    var deviceData = createHiddenParameter(CONST.DEVICE_DATA, this.deviceData);

    var cardholder = createHiddenParameter(CONST.CARDHOLDER, $(CONST.CARD_HOLDER_ID).val());

    submitForm.append($(deviceData));
    submitForm.append($(useDelivery));
    submitForm.append($(paymentType));
    submitForm.append($(cardType));
    submitForm.append($(cardDetails));
    submitForm.append($(cardholder));

    submitForm.submit()
}

function createForm(name, action) {
    var form = $(HTML.FORM).attr(CONST.ATTR_ACTION, action)
        .attr(CONST.ATTR_NAME, name).attr(CONST.ATTR_METHOD, CONST.FORM_METHOD_POST);
    return form;
}

function createHiddenParameter(name, value) {
    var input = $(HTML.INPUT).attr(HTML.TYPE, "hidden").attr(CONST.ATTR_NAME, name).val(
        value);
        
    return input;
}

function checkSavedPaymentMethods(paymentType, isAvailable) {
    let payments =  $('.paymentType');
    var  isEnabledPayment = isPaymentEnabled(paymentType);

    payments.each(function () {
        if (($(this).val() == paymentType) && (!isAvailable || !isEnabledPayment)) {
            $(this).next().remove();
            $(this).remove();
            console.log($(this).val());
        } else {
            if (canRemoveHide($(this).val(), paymentType)) {
                $(this).next().removeClass(CONST.HIDE);
            }
        }
    });

    if (typeof paymentMethodsPage != 'undefined') {
        if (!anotherPaymentPresent(payments, paymentType) && (!isAvailable || !isEnabledPayment)) {
            $('#savePaymentButton').remove();
        } else {
            $('#savePaymentButton').removeClass(CONST.HIDE);
        }
    }
}

function canRemoveHide(elem, type){
    if (elem===CONST.VENMO_ACCOUNT && type != CONST.VENMO_ACCOUNT){
        return false;
    }

    if (elem===CONST.GOOGLE_PAY_ACCOUNT && type != CONST.GOOGLE_PAY_ACCOUNT){
        return false;
    }
    return true;
}

function anotherPaymentPresent(payments, paymentType){
    return payments.toArray().some(value => value['value']!=paymentType);
}

function isPaymentEnabled(paymentType){
    if (paymentType===CONST.VENMO_ACCOUNT){
        return  venmoEnabled;
    }else if (paymentType===CONST.GOOGLE_PAY_ACCOUNT){
        return googlePayEnabled;
    }

    return false;
}

function configurePayPalAlongWithHostedFields() {

    // remove paypal validation messages
    $(CONST.GLOBAL_MESSAGES).children(CONST.VALIDATION_CLASS).remove();

    // add select payment method event
    $(CONST.PAYMENT_METHOD_SECTION).change(function () {
        paymentMethod();
    });

    // render appropriate payment method
        selectPaymentMethod();
}



function selectPaymentMethod() {
    if (typeof isCreditCardSelect != 'undefined' && isCreditCardSelect != '' && isCreditCardSelect == "true") {
        $(CONST.PAYMENT_METHOD_BT_ID).prop(CONST.PROP_CHECKED, true);
        $(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).attr('type', 'submit');
    } else if (typeof isSingleUseSelect != 'undefined' && isSingleUseSelect != '') {
        $(CONST.PAYMENT_METHOD_PAYPAL).prop(CONST.PROP_CHECKED, true);
        // select paypal as default
    } else {
        $(CONST.PAYMENT_METHOD_PAYPAL).prop(CONST.PROP_CHECKED, true);
        $(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).attr('type', 'button');
       /* if(isAvailableVenmo()){
            $(CONST.PAYMENT_METHOD_VENMO).prop(CONST.PROP_CHECKED, true);
            $(CONST.VENMO_SELECTOR).removeClass(CONST.HIDE);
        } else {
            $(CONST.VENMO_SELECTOR).remove();
        }*/

        disableRadioButton();
    }
    triggerCheckedPaymentMethod();
}


function disableRadioButton() {
    var radioButtons = $(CONST.PAYMENT_METHOD_SECTION);
    if (radioButtons.length === 1) {
        radioButtons.prop(CONST.PROP_CHECKED, true);
        radioButtons.hide();
    } else if (radioButtons.length === 0) {
        $(CONST.NO_PAYMENT_METHODS_MESSAGE).removeClass('hidden');
        paymentMethod();
    } else if (!radioButtons.is(HTML.CHECKED)) {
        radioButtons.filter(':first').prop(CONST.PROP_CHECKED, true);
    }
}

function triggerCheckedPaymentMethod(){
    var radioButtons = $(CONST.PAYMENT_METHOD_SECTION);
    radioButtons.filter(HTML.CHECKED).trigger(EVENTS.CHANGE);
}

function paymentMethod() {
    if (isPayPalMethodSelected()) {
        $(CONST.MARK_PAYPAL_BUTTON).show();
        $(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).hide();
        $(CONST.VENMO_BUTTON).hide();
        $(CONST.GOOGLE_PAY_BUTTON).hide();
        $(CONST.HOSTED_FIELDS).hide();
        $(CONST.LPM_BUTTONS).hide();
        $(CONST.BILLING_ADDRESS_DATA).hide();
        $(CONST.CREADIT_CARD_LABEL_ID).removeClass(CONST.HEADLINE);
        $(CONST.PAYPAL_CMS_IMAGE_SELECTOR).removeClass(CONST.DISABLE_CLICK);
        $(CONST.SELECT_PAYMENT).val(CONST.PAYPAL);
        $(CONST.GLOBAL_MESSAGES).children('.bt_validation').remove();
        if (paypalIntent === CONST.INTENT_ORDER) {
            $("#savePaymentInfoComponent").hide();
        } else {
            $("#savePaymentInfoComponent").show();
        }
    } else if (isApplePaySelected()) {
        $(CONST.LPM_BUTTONS).hide();
        $(CONST.GOOGLE_PAY_BUTTON).hide();
        $(CONST.VENMO_BUTTON).hide();
        $(CONST.HOSTED_FIELDS).hide();
        $(CONST.BILLING_ADDRESS_DATA).hide();
        $(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).show();
        $(CONST.MARK_PAYPAL_BUTTON).hide();
        $(CONST.CREADIT_CARD_LABEL_ID).removeClass(CONST.HEADLINE);
        $(CONST.SELECT_PAYMENT).val(CONST.APPLEPAY_VAL);
        $(CONST.GLOBAL_MESSAGES).children('.bt_validation').remove();
        $("#savePaymentInfoComponent").hide();
        $("#savePaymentInfoComponent").prop("checked", false);
    } else if (isGooglePaySelected()) {
        $(CONST.GOOGLE_PAY_BUTTON).show();
        $(CONST.VENMO_BUTTON).hide();
        $(CONST.LPM_BUTTONS).hide();
        $(CONST.HOSTED_FIELDS).hide();
        $(CONST.BILLING_ADDRESS_DATA).hide();
        $(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).hide();
        $(CONST.MARK_PAYPAL_BUTTON).hide();
        $(CONST.CREADIT_CARD_LABEL_ID).removeClass(CONST.HEADLINE);
        $(CONST.GLOBAL_MESSAGES).children('.bt_validation').remove();
        $("#savePaymentInfoComponent").show();
    } else if (isLocalPaymentsSelected()) {
        $(CONST.LPM_BUTTONS).show();
        $(CONST.VENMO_BUTTON).hide();
        $(CONST.GOOGLE_PAY_BUTTON).hide();
        $(CONST.HOSTED_FIELDS).hide();
        $(CONST.BILLING_ADDRESS_DATA).hide();
        $(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).hide();
        $(CONST.MARK_PAYPAL_BUTTON).hide();
        $(CONST.CREADIT_CARD_LABEL_ID).removeClass(CONST.HEADLINE);
        $(CONST.GLOBAL_MESSAGES).children('.bt_validation').remove();
        $("#savePaymentInfoComponent").hide();
        $("#savePaymentInfoComponent").prop("checked", false);
    } else if (isVenmoSelected()) {
        $(CONST.VENMO_BUTTON).show();
        $(CONST.LPM_BUTTONS).hide();
        $(CONST.GOOGLE_PAY_BUTTON).hide();
        $(CONST.HOSTED_FIELDS).hide();
        $(CONST.BILLING_ADDRESS_DATA).hide();
        $(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).hide();
        $(CONST.MARK_PAYPAL_BUTTON).hide();
        $(CONST.CREADIT_CARD_LABEL_ID).removeClass(CONST.HEADLINE);
        $(CONST.GLOBAL_MESSAGES).children('.bt_validation').remove();
        $("#savePaymentInfoComponent").show();
    } else if (isBrainTreeMethodSelected()){
        $(CONST.LPM_BUTTONS).hide();
        $(CONST.GOOGLE_PAY_BUTTON).hide();
        $(CONST.VENMO_BUTTON).hide();
        $(CONST.HOSTED_FIELDS).show();
        $(CONST.BILLING_ADDRESS_DATA).show();
        $(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).show();
        $(CONST.MARK_PAYPAL_BUTTON).hide();
        $(CONST.CREADIT_CARD_LABEL_ID).addClass(CONST.HEADLINE);
        $(CONST.PAYPAL_CMS_IMAGE_SELECTOR).addClass(CONST.DISABLE_CLICK);
        $(CONST.SELECT_PAYMENT).val("bt");
        $("#savePaymentInfoComponent").show();
    }else {
        $(CONST.MARK_PAYPAL_BUTTON).hide();
        $(CONST.LPM_BUTTONS).hide();
        $(CONST.HOSTED_FIELDS).hide();
        $(CONST.BILLING_ADDRESS_DATA).hide();
        $(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).hide();
        $("#savePaymentInfoComponent").hide();
        if (typeof addPaymentMethodsPage != 'undefined') {
            $(".account-section-header").hide();
        }
    }
}

function isApplePaySelected() {
    return $('input[name=paymentMethodSelection]:radio:checked').val() == CONST.APPLEPAY_VAL || $('input[name=onlyApplePaySelected]').val() == 'true';
}

function isBrainTreeMethodSelected() {
    return $('input[name=paymentMethodSelection]:radio:checked').val() == CONST.BT_VAL;
}

function isPayPalMethodSelected() {
    return $('input[name=paymentMethodSelection]:radio:checked').val() == CONST.PAYPAL_VAL || $('input[name=onlyPayPalSelected]').val() == 'true';
}

function isLocalPaymentsSelected() {
    return $('input[name=paymentMethodSelection]:radio:checked').val() == CONST.LOCAL_PAYMENTS_VAL || $('input[name=onlyLocalPaymentsSelected]').val() == 'true';
}

function isVenmoSelected() {
    return $('input[name=paymentMethodSelection]:radio:checked').val() == CONST.VENMO_VAL || $('input[name=onlyVenmoSelected]').val() == 'true';
}

function isGooglePaySelected() {
    return $('input[name=paymentMethodSelection]:radio:checked').val() == CONST.GOOGLEPAY_VAL || $('input[name=onlyGooglePaySelected]').val() == 'true';
}