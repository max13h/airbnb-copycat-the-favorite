var HTML = {
    DIV: "<div>",
    BR: "<br/>",
    IMG: "<img/>",
    INPUT: "<input>",
    FORM: "<form>",
    CLASS: "class",
    SRC: "src",
    ALT: "alt",
    SCRIPT: "script",
    TYPE_TEXT: "text/javascript",
    HEAD: "head",
    CURSOR: "cursor",
    POINTER: "pointer",
    CHECKED: ":checked",
    TYPE: "type",
    FOOTER: "footer"
};
var CONST = {
    ADD_TO_CART_BUTTON: ".addToCartButton",
    ADD_TO_CART_LAYER: "#cboxContent",
    ADD_TO_CART_DIV: ".addtocart",
    PAYPAL_CHECKOUT_IMAGE: ".payPalCheckoutAddToCartImage",
    SINGLE_USE_CHECKBOX: "#singleUseCheckboxAddToCart",
    MINI_CART: ".miniCart",
    MINI_CART_LAYER: "#miniCartLayer",
    PAYPAL_CHECKOUT_MINI_IMAGE: ".payPalCheckoutMiniCartImage",
    SINGLE_USE_MINI_CHECKBOX: "#singleUseCheckboxMiniCart",
    FOOTER: ".footer",
    PAYMENT_OPTIONS: "paymentOptions",
    PAYMENT_OPTIONS_CLASS: ".paymentOptions",
    FOOTER_IMG_SRC: "https://www.paypalobjects.com/webstatic/en_US/i/buttons/cc-badges-ppmcvdam.png",
    PAYMENT_OPTIONS_TEXT: "Payment options",
    GLOBAL_MESSAGES: "#globalMessages",
    VALIDATION_CLASS: ".bt_validation",
    ERROR_DIV: "<div class='alert alert-danger'>",
    PAYMENT_MEHTOD_SECTION: "[name=paymentMethodSelection]",
    BT_LIBS: [
        "https://js.braintreegateway.com/web/3.52.0/js/client.js",
        "https://js.braintreegateway.com/web/3.52.0/js/data-collector.js",
        "https://js.braintreegateway.com/web/3.52.0/js/paypal-checkout.js",
        "https://js.braintreegateway.com/web/3.52.0/js/apple-pay.min.js",
        "https://www.paypalobjects.com/api/checkout.js"
    ],
    HOSTED_FIELDS: ".hostedFields",
    BILLING_ADDRESS_DATA: ".billingAddressData",
    CREADIT_CARD_LABEL_ID: "#creditCardLabelId",
    HEADLINE: 'headline',
    DISABLE_CLICK: 'disableClick',
    PAYPAL: 'paypal',
    APPLEPAY_VAL: "applePay",
    SELECT_PAYMENT: '#select_payment',
    PAYMENT_METHOD_PAYPAL: '#paymentMethodPayPal',
    PROP_CHECKED: 'checked',
    PAYMENT_TYPE: "payment_type",
    CARD_TYPE: "card_type",
    CARD_DETAILS: "card_details",
    PAYMENT_METHOD_NONCE: "bt_payment_method_nonce",
    ATTR_ACTION: "action",
    ATTR_METHOD: "method",
    ATTR_NAME: "name",
    PAYPAL_CMS_IMAGE_SELECTOR: '.paypalimage .cmsimage img',
    PAYPAL_CHECKOUT_IMAGE_SELECTOR: '.payPalCheckoutImage .cmsimage img',
    LIABILITY_SHIFTED: "liability_shifted",
    ERROR_ALERT_NEGATIVE_CSS_CLASS: 'alert alert-danger alert-dismissable',
    FORM_METHOD_POST: "POST",
    BRAINTREE_PAYMENT_FORM_ID: 'braintree-payment-form',
    SUBMIT_CILENT_ORDER_POST_FORM_ID: '#submit_silentOrderPostForm',
    SAVE_PAYMENT_INFO_ID: '#savePaymentInfo',
    SINGLE_USE_CHECKBOX_ID: '#singleUseCheckbox',
    ALERT_POSITIVE_BT_VALIDATION_CSS_CLASS: 'alert positive bt_validation',
    NUMBER_ID: "#number",
    EXPIRATION_MONTH: "#expiration-month",
    EXPIRATION_YEAR: "#expiration-year",
    CVV_ID: "#cvv",
    PAYMENT_METHOD_BT_ID: '#paymentMethodBT',
    /*USE_DELIVERY_ADDRESS_ID: '#contactChoice1',*/
    USE_DELIVERY_ADDRESS_ID: '#useDeliveryAddress',
    PAYPAL_EXPRESS_FORM_NAME: "payPalExpress",
    CUSTOM_SINGLE_USE_CHECKBOX_ID: '#customSingleUseCheckbox',
    PAYPAL_IS_VALID_ID: '#paypal_is_valid',
    PAYPAL_EMAIL_ID: '#paypal_email',
    PAYPAL_EXPRESS_ERROR_ID: '#paypal_express_error',
    CARD_HOLDER_ID: "#cardholderName",
    CONTAINER_CLASS: ".container-fluid",
    PAYPAL_VAL: "paypal",
    KLARNA_VAL:"klarna",
    BT_VAL: "bt",
    PAYPAL_BUTTON_CONTAINER: ".paypal-button-in-popup",
    PAYPAL_BUTTON_CART_CONTAINER: ".paypal-button-in-cart-popup",
    PAYPAL_BUTTON: ".paypal-button",
    MARK_PAYPAL_BUTTON: "#mark-paypal-button",
    VAULT_FLOW: "vault",
    CHECKOUT_FLOW: "checkout",
    TRUE: "true",
    ON_SUCCESS: "onSuccess",
    INTENT_SALE: "sale",
    INTENT_ORDER: "order",
    APPLE_PAY_BUTTON_SELECTOR: ".apple-pay-button",
    HIDE: "hide",
    PAYMENT_METHOD_APPLE_PAY: "#paymentMethodApplePay",
    APPLE_PAY_BUTTON_CONTAINER: ".apple-pay-button-container",
    APPLEPAY_SELECTOR: "#applepay",
    INTENT_AUTHORIZE: "authorize",
    USER_SELECTED_PAYMENT_INFO:"#userSelectedPaymentInfo",
    CHECKBOX_TC:".checkbox-tc",
    HIDE_BUTTON:"hideButton",
    EXPIRATION_YEAR_ID: "#expirationYear",
    EXPIRATION_MONTH_ID: "#expirationMonth",
    KLARNA_DIV:"klarna_div"
};


jQuery(document).ready(function ($) {
    var deviceData;
    var paypalDeviceData;
    var client;
    var paymentMethodResponse;
    $("#save-address").prop('checked', true);
    if($("#amount_entered").length == 1 && $("#amount_remaining").length == 1)
	{
		$("#modify_order-payment-amount").val($("#amount_entered").val());
		$("#modify_order-payment-amount").prop('readOnly', true);
		$("#modify_order-payment-remaining-amount").val($("#amount_remaining").val());
		$("#modify_order-payment-remaining-amount").prop('readOnly', true);
	}
	if($("#paymentAddNewAddress").length <= 0)
	{
		$("#showSavedAddresses").hide();
		$("#billing-address-form-expand").toggle();
	}
	if($("#addNewCardForm").length <= 0)
	{
		$("#credit-card-form-expand").toggle();
	}
	if($("#isCCPresent") != '' && $("#isCCPresent").val() != '' && $("#isCCPresent").val() === 'true')
	{
		$("#submit_silentOrderPostForm").hide();
		$("#paymentMethodBT").click();
	}
	else if($("#isPayPalPresent") != '' && $("#isPayPalPresent").val() != '' && $("#isPayPalPresent").val() === 'true')
	{
		$("#paymentMethodPayPal").click();
		$("#submit_silentOrderPostForm").hide();
	}	
	else
	{
		$("#submit_silentOrderSavedForm").hide();
	}
	if($("#isPOPresent") != '' && $("#isPOPresent").val() != '' && $("#isPOPresent").val() === 'true')
	{
	  $("#paymentMethodPo").click();
	}
	if($("#isAddressPresent") != '' && $("#isAddressPresent").val() != '' && $("#isAddressPresent").val() === 'true')
	{
		$("#billing-address-saved").addClass("show");
        $('#billing-address-saved a').each(function() {            
            var optionText = this.text;
          //  var newOption = optionText.substring(0,58);
          //  if(screen.width<600){
           //     var newOption = optionText.substring(0,35);
            //}
           // if(optionText > optionText.substring(0,64)){
           //     jQuery(this).text(newOption + '..');
           // }
        }); 
        
        $('.for-credit-card a').each(function() {            
            var optionText = this.text;
          //  var newOption = optionText.substring(0,51);
           // if(screen.width<600){
            //    var newOption = optionText.substring(0,35);
           // }
           // if(optionText > optionText.substring(0,59)){
            //    jQuery(this).text(newOption + '..');
           // }
        });
	}
	if($("#savePaymentInfo").length == 1)
	{
		$("#savePaymentInfo").prop('checked', true);
	}
    // add payment method images to footer section for all pages
    addPaymentMethodImagesToFooter();

    if (isAvailableApplePay()) {
        disableApplePay();
        $(CONST.APPLEPAY_SELECTOR).removeClass(CONST.HIDE);
    } else {
        $(CONST.APPLEPAY_SELECTOR).remove();
    }

    // PayPal along with Hosted Fields checkout configuration
    /*if ((typeof paymentMethodsPage != 'undefined')) {
        //check if google pay supported display radio
        checkVenmoPaymentMethods();
        createClientInstance(CONST.GLOBAL_MESSAGES, function(){
            if (googlePayEnabled) {
                initialiseGooglePay();
            }
            configurePayPalAlongWithHostedFields();
        })
    }*/

    if (typeof accountPaymentInfoPage != 'undefined') {
        configureAccountPaymentInfoPage();
    }

    //This code is not required 
    
    /*if ((typeof addPaymentMethodsPage != 'undefined')) {

        enableShippingAddress = "false";

        checkVenmoPaymentMethods();

        createClientInstance(CONST.GLOBAL_MESSAGES, function(){

            if (googlePayEnabled) {

                initialiseGooglePay();

            }

            configurePayPalAlongWithHostedFields();

        })

    }*/

    // PayPal Shopping Cart Shortcut checkout configuration
    if (typeof shoppingCart != 'undefined' && shoppingCart != '') {
        configurePaypalShortcut(CONST.PAYPAL_BUTTON);
    }

    if (typeof isCreditMessagesEnabled != 'undefined' && typeof shoppingCart == 'undefined') {
        configurePageForCreditMessage();
    }
});

$(CONST.PAYMENT_METHOD_BT_ID).change(function () {
	$("#allFieldvalidationMessage").empty();
	if($("#savedCCCardId").val() == '')
	{
		if($("#addNewCardForm").length <= 0)
		{
			$('.page-loader-new-layout').show();
			initializeBTclientSDK();
			$( "#credit-card-form-expand" ).addClass("show");
			$("#showSavedCard").hide();
		}
		else if($(CONST.PAYMENT_METHOD_BT_ID).hasClass("reInitialize") == true)
		{
			$('.page-loader-new-layout').show();
			initializeBTclientSDK();
		}		
	}
	if($(".js-modify-order-capture-payment").length >= 1)
		{
			$(".js-modify-order-capture-payment").attr("disabled",false);
		}
		if($(".js-order-deposit-payment").length >= 1)
		{
			$(".js-order-deposit-payment").attr("disabled",false);
		}
});

if ((typeof addPaymentMethodsPage != 'undefined')) {
  jQuery(document).ready(function () {
	  initializeBTclientSDK();
  });
}

$(CONST.PAYMENT_METHOD_PAYPAL).change(function () {
	$('.page-loader-new-layout').show();
	$("#mark-paypal-button").empty();
	if($(".js-order-deposit-payment").length >= 1)
		{
			$(".js-order-deposit-payment").attr("disabled",true);
		}
    createPayPalPaymentMarkFlow(createPayPalOptions());
});

$(CONST.PAYMENT_METHOD_APPLE_PAY).change(function () {
    createApplePay(createPayPalOptions(), CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID, function (payload) {
        processApplePayResponse(payload);
    })

});

$(CONST.PAYMENT_METHOD_GOOGLE_PAY).change(function () {
    resetHostedFields();
    if ($(CONST.GOOGLE_PAY_BUTTON).length > !1 && $(CONST.GOOGLE_PAY_BUTTON).is(":empty")) {
        setupGooglePayButton();
    }
});

$(CONST.PAYMENT_METHOD_LOCAL_PAYMENT).change(function () {
    resetHostedFields();
    createLocalPayment();
});

$(CONST.PAYMENT_METHOD_VENMO).change(function () {
    resetHostedFields();
    renderVenmoButton();
});

$("form[id^='savedPaymentInfoForm']").on('submit', function (e) {
    initialise3dSecure(e);
});

function addPaymentMethodImagesToFooter() {
    var paymentOptionsTextDiv = $(HTML.DIV).attr(HTML.CLASS, CONST.PAYMENT_OPTIONS);
    var br = $(HTML.BR);
    $(CONST.FOOTER).prepend(br);
    $(CONST.FOOTER).prepend(br);
    $(CONST.FOOTER).prepend(paymentOptionsTextDiv);
    var paymentOptionsImage = $(HTML.IMG);
    paymentOptionsImage
        .attr(
            HTML.SRC,
            CONST.FOOTER_IMG_SRC);
    paymentOptionsImage.attr(HTML.ALT, CONST.PAYMENT_OPTIONS_TEXT);
    $(HTML.FOOTER).children(CONST.CONTAINER_CLASS).append(paymentOptionsImage);
}

function activatePaypalStandardImage() {
    $(CONST.PAYPAL_CHECKOUT_IMAGE_SELECTOR).hover(function () {
        $(this).css('cursor', 'pointer');
    });
}

function selectIsSingleCheckbox() {
    if (JSON.parse(singleUse)) {
        $(CONST.SINGLE_USE_CHECKBOX_ID).prop(CONST.PROP_CHECKED, false);
        // initialize standard paypal by braintree
        initialisePaypal(CONST.PAYPAL_BUTTON);
    } else {
        $(CONST.SINGLE_USE_CHECKBOX_ID).prop(CONST.PROP_CHECKED, true);
        // initialize standard paypal by braintree
        initialisePaypal(CONST.PAYPAL_BUTTON);
    }
}

function showRemovePaymentDetailsConfirmation(paymentInfoID) {
    $.colorbox({
        href: "#popup_confirm_payment_removal_" + paymentInfoID,
        inline: true,
        maxWidth: "100%",
        opacity: 0.7,
        width: "320px",
        onComplete: function () {
            $(this).colorbox.resize();
        }
    });
}

function bindToColorboxClose() {
    $.colorbox.close();
}

function receiveNewAddressData(selectedAddressID) {
    $.ajax({
        url: ACC.config.encodedContextPath + '/my-account/receive-address',
        type: 'GET',
        data: { "selectedAddressCode": selectedAddressID },
        success: function (result) {
            var selectedAddress = $.parseJSON(result);
            $("#title").text(selectedAddress.title);
            $("#firstName").text(selectedAddress.firstName);
            $("#lastName").text(selectedAddress.lastName);
            $("#line1").text(selectedAddress.line1);
            $("#line2").text(selectedAddress.line2);
            $("#town").text(selectedAddress.town);
            $("#postalCode").text(selectedAddress.postalCode);
            $("#country-name").text(selectedAddress.country.name);
            if (selectedAddress.region != null) {
                $("#region-name").text(selectedAddress.region.name);
            } else {
                $("#region-name").text("");
            }
            $("#billingAddressId").val(selectedAddress.id);
        }
    });
    $.colorbox.close();
}



function initializeBTclientSDK() {
    var isIntentValid = checkIntentOption(paypalIntent);
    /*  payPalMarkButtonConfigObj = eval("({" + payPalMarkButtonConfig.replace('\"', '"') + "})");

     if (!isAvailableApplePay()) {
         $(CONST.APPLEPAY_SELECTOR).remove();
     } else {
         $(CONST.APPLEPAY_SELECTOR).removeClass("hide");
     }*/

    var checkout;
    var paypalOptions;

    // reset hosted fields in case repeated initialization
    resetHostedFields();
    var dataCollector = {};
    /* var paypalFlow = getPaypalFlow();

     var paypalOptions = {
         flow: paypalFlow,
         enableShippingAddress: JSON.parse(enableShippingAddress),
         enableBillingAddress: true,
         locale: braintreeLocale,
         shippingAddressEditable: false
     };

     if (userAction === 'true' && paypalIntent === CONST.INTENT_SALE) {
         // paypalOptions.useraction='commit';
     }

     // configure advance fraud tools
     var dataCollector = {};

     //add payment method page
     if ((typeof addPaymentMethodsPage != 'undefined')) {

         dataCollector.paypal = true;
         paypalOptions.billingAgreementDescription = billingAgreementDescription;

     } else {
         // configure paypal connections
         if (paypalFlow == CONST.CHECKOUT_FLOW) {
             if (paypalIntent != undefined && paypalIntent !== "") {
                 paypalOptions.intent = paypalIntent;
             }
             paypalOptions.amount = amount;
             paypalOptions.currency = currency;
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
         } else if (paypalFlow == CONST.VAULT_FLOW) {
             if (paypalIntent != undefined && paypalIntent !== "") {
                 paypalOptions.intent = paypalIntent;
             }
             paypalOptions.amount = amount;
             paypalOptions.currency = currency;
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

             paypalOptions.billingAgreementDescription = billingAgreementDescription;

             // configure advanced fraud tools only for vaulted PayPal
             if (JSON.parse(advancedFraudToolsEnabled)) {
                 dataCollector.paypal = true;
             }

             // configure display name for paypal connection
             if (typeof dbaName != 'undefined' && dbaName != '') {
                 if (dbaName.indexOf('*') > -1) {
                     paypalOptions.displayName = dbaName.substr(0, dbaName.indexOf('*'));
                 }
             }
         }
     }*/

    // Configure braintree client SDK
    if ((typeof clientToken != 'undefined' && clientToken != '')
        && (typeof braintree != 'undefined' && braintree != '')) {

        braintree.client.create({
            authorization: clientToken
        }, function (clientErr, clientInstance) {
            if (clientErr) {
                handleClientError(clientErr);
                return;
            }


            if (isBrainTreeMethodSelected() || (typeof addPaymentMethodsPage != 'undefined')) {
            	createHostedFields(clientInstance);                
            }


            dataCollector.client = clientInstance;
            if (JSON.parse(advancedFraudToolsEnabled)) {
                dataCollector.paypal = true;
            }
            createDataCollector(dataCollector);

            if (isIntentValid === false) {
                var globalErrorsComponent = $(CONST.MARK_PAYPAL_BUTTON);
                globalErrorsComponent.empty();
                globalErrorsComponent.append(createErrorDiv(ACC.addons.braintree1811addon['braintree.message.incorect.intent']))

            } else if (isPayPalMethodSelected()) {

                braintree.paypalCheckout.create({
                    client: clientInstance
                }, function (paypalCheckoutErr, paypalCheckoutInstance) {

                    var braintreeEnvironment = clientInstance.getConfiguration().gatewayConfiguration.environment;

                    var checkoutJs = {
                        style: {
                            size: 'responsive',
                            shape: 'rect',
                            label: 'paypal',
                            tagline : 'false',
                            height : 40
                        }
                    };

                    $(CONST.MARK_PAYPAL_BUTTON).html('');
                    // Start Paypal Checkout.js Javascript
                    paypal.Button.render(Object.assign({
                            env: braintreeEnvironment === 'production' ? 'production' : 'sandbox',
                            payment: function (resolve, reject) {
                                console.log("paypalOptions: " + JSON.stringify(paypalOptions, null, 1));
                                paypalCheckoutInstance.createPayment(paypalOptions, function (err, res) {
                                    if (err) {
                                        handleCreatePaymentError(err);
                                        reject(err);
                                    } else {
                                        resolve(res);
                                    }
                                });
                            },
                            style: checkoutJs.style,
                            locale: braintreeLocale,
                            // commit: userAction,

                            onAuthorize: function (data, actions) {
                                actions.close();
                                return new paypal.Promise(function (resolve, reject) {
                                    return paypalCheckoutInstance.tokenizePayment(data).then(function (payload) {
                                        processPaypalResponse(payload, false);
                                    }).catch(function (tokenizeErr) {
                                        handlePayPalExpressClientError(tokenizeErr);
                                    });
                                });
                            },
                            onCancel: function (data) {
                                console.log('Cancel:', data);
                            },
                            onError: function (err) {
                                console.error('Error: ' + err, err);
                            }
                        },
                        payPalMarkButtonConfigObj), CONST.MARK_PAYPAL_BUTTON).then(function () {
                        console.log('PayPal button ready!');
                    });
                });
            }

            if (isApplePaySelected()) {
                $(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).unbind(EVENTS.CLICK);
                createApplePay(clientInstance, paypalOptions, CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID, function (payload) {
                    showSuccessPaypalMessage(payload.nonce, payload.details.email);
                    processResponce(payload);
                });
            }
        });

    } else {
        var globalErrorsComponent = $(CONST.GLOBAL_MESSAGES);
        globalErrorsComponent.empty();
        /*  globalErrorsComponent.append(createErrorDiv(ACC.addons.braintree1811addon['braintree.message.use.saved.payments']));*/
    }
}
function isBrainTreeMethodSelected() {
    var abc =  $('input[name=paymentMethodSelection]:radio:checked').val() == CONST.BT_VAL;
    return $('input[name=paymentMethodSelection]:radio:checked').val() == CONST.BT_VAL;
}

function creditCardValidation(errorMessage){
	
	 var validationDiv = $('<div class="notification notification-error mb-4" />').text(errorMessage);
	 $('#validationMessage').append(validationDiv);
}

function allFieldValidation(errorMessage){
	
	 var validationDiv = $('<div class="notification notification-error mb-4" />').text(errorMessage);
	  $('#allFieldvalidationMessage').append(validationDiv);
	  document.getElementById('allFieldvalidationMessage').scrollIntoView(true);
}



function createHostedFields(clientInstance) {
    var name = $("#userSelectedPaymentInfo_name").val();
    var number = $("#userSelectedPaymentInfo_number").val();
    var expiryMonth = $("#userSelectedPaymentInfo_month").val();
    var expiryYear = $("#userSelectedPaymentInfo_year").val();

    if(name){
        $(CONST.CARD_HOLDER_ID).val(name);
    }
    var numberPlaceholder = 'Card Number';

    if(number){
        numberPlaceholder=number;
        $(".crs-checkout-payment-credit-card-number").text(number);
        $('.cvvNumber').hide();
        $('#saved_cvv').show();
    }
    //$(CONST.CARD_HOLDER_ID).attr("placeholder", "Card Holder name *");
    braintree.hostedFields.create({
            client: clientInstance,
            styles: {
                // Styling element state
                ":focus": {
                    "color": "black",
                    "color": "#212529",
                    "border-color": "#86b7fe",
                    "outline": "0",
                    "box-shadow": "0px 0px 6px -1px #86b7fe",                    	 
                    "padding-left": "13px",
                    "border": "1px solid #86b7fe",
                    "border-radius": "3px",
                    "height":"45px"  
                },
                ".valid": {
                    "color": "black"
                },
                ".invalid": {
                    "color": "red"
                },
                "input": {
                    "font-size": "1rem",
                    "padding-left": "13px",	
                },
                "select": {
                    "font-size": "1rem",
                    "color": "#565656"
                }
                

            },
            fields: {
                number: {
                    selector: "#number",
                    	placeholder: "Card Number"	
                },
                
                expirationMonth: {
                    selector: '#expirationMonth',
                  
                    prefill: expiryMonth,
                    placeholder : 'Month',
                    select: {
                      options: [
                        '01   Jan',
                        '02   Feb',
                        '03   Mar',
                        '04   Apr',
                        '05   May',
                        '06   Jun',
                        '07   Jul',
                        '08   Aug',
                        '09   Sep',
                        '10   Oct',
                        '11   Nov',
                        '12   Dec'
                      ]
                    }
                  },
                  expirationYear: {
                      selector: '#expirationYear',
                      prefill: expiryYear,
                     placeholder : 'Year',
                      select: {

                        }                 
                  },
                
                  cvv: {
                    selector: '#cvv',
                    placeholder : 'CVV'	
                }
            }
        },


        function (hostedFieldsErr, hostedFieldsInstance) {

            if (hostedFieldsErr) {
            
                handleClientError(hostedFieldsErr);
                return;
            }

            var state =  hostedFieldsInstance.getState();
            var fields = Object.keys(state.fields);


            hostedFieldsInstance.on('focus', function (event) {
                $('.form-control').css("border","1px solid #666 !important");
                /!*$('label.csr-payment-method-floating-label').addClass('csr-focused-payment-method-label')*!/
            });

            hostedFieldsInstance.on('blur', function (event) {
                $('.form-control').css("border-left","3px solid #4a9145 !important");
                /!* $('label.csr-payment-method-floating-label').removeClass('csr-focused-payment-method-label')*!/
            });


            /!* label code *!/
            hostedFieldsInstance.on('focus', function(event) {

                var field = event.fields[event.emittedBy];

                $(field.container).next('label.csr-payment-method-floating-label').addClass('csr-focused-payment-method-label');
            });

            hostedFieldsInstance.on('blur', function(event) {


                var field = event.fields[event.emittedBy];


                if(field.isEmpty === false) {
                    $(field.container).next('label.csr-payment-method-floating-label').addClass('csr-focused-payment-method-label');
                } else {
                    $(field.container).next('label.csr-payment-method-floating-label').removeClass('csr-focused-payment-method-label');
                }
            });

            hostedFieldsInstance.on('empty', function(event) {

                var field = event.fields[event.emittedBy];
                $(field.container).next('label.csr-payment-method-floating-label').removeClass('csr-focused-payment-method-label');
            });

            hostedFieldsInstance.on('notEmpty', function(event) {

                var field = event.fields[event.emittedBy];
                $(field.container).next('label.csr-payment-method-floating-label').addClass('csr-focused-payment-method-label');
            });

            /!* label code end *!/


            hostedFieldsInstance.on('cardTypeChange', function (event) {

                var state =  hostedFieldsInstance.getState();
                var fields = Object.keys(state.fields);


                if(!state.fields.number.isEmpty)
                {
                    $('.errorMessageForWrongCard').hide();
                    if(!state.fields.number.isPotentiallyValid)
                    {
                        $('.errorMessageForWrongCard').show();
                        $('.selectedCard').removeClass();
                    }

                    else if(event.cards[0].niceType === 'Visa'){
                        $('.selectedCard').removeClass();
                        $('#001').addClass("selectedCard")
                    }

                    else if(event.cards[0].niceType === 'Mastercard'){
                        $('.selectedCard').removeClass();
                        $('#002').addClass("selectedCard")
                    }

                    else if(event.cards[0].niceType === 'Discover'){
                        $('.selectedCard').removeClass();
                        $('#004').addClass("selectedCard")
                    }

                    else if(event.cards[0].niceType === 'Diners Club'){
                        $('.selectedCard').removeClass();
                        $('#005').addClass("selectedCard")
                    }


                    else if(event.cards[0].niceType === 'JCB'){
                        $('.selectedCard').removeClass();
                        $('#007').addClass("selectedCard")
                    }


                    else if(event.cards[0].niceType === 'American Express'){
                        $('.selectedCard').removeClass();
                        $('#003').addClass("selectedCard")
                    }


                    else if(event.cards[0].niceType === 'UnionPay'){
                        $('.selectedCard').removeClass();
                        $('#401').addClass("selectedCard")
                    }
                    else if(!(event.cards[0].niceType === 'UnionPay' || event.cards[0].niceType === 'American Express'|| event.cards[0].niceType === 'JCB'||
                        event.cards[0].niceType === 'Diners Club' || event.cards[0].niceType === 'Discover' || event.cards[0].niceType === 'Mastercard' ||
                        event.cards[0].niceType === 'Visa')){
                        $('.errorMessageForWrongCard').show();
                        $('.selectedCard').removeClass();
                    }
                    else{
                        $('.errorMessageForWrongCard').hide();
                        $('.selectedCard').removeClass();
                    }

                }

                if(state.fields.number.isEmpty)
                {
                    $('.errorMessageForWrongCard').hide();
                    $('.selectedCard').removeClass();
                }



            });


            $(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).unbind(EVENTS.CLICK);
            

            // Add a click event listener to PayPal image
            $(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).click(function (e) {
            	e.preventDefault();
            	$('.page-loader-new-layout').show();
				$('.global-alerts').hide();
				$('#validationMessage').empty();
				$(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).addClass("disbleButtonColor");
				var hasNoError = true;
				var state =  hostedFieldsInstance.getState();
				var fields = Object.keys(state.fields);
           
				var saveBillingAddressVal = $("#savedBillingAddressId").val();
				
				if((typeof addPaymentMethodsPage != 'undefined') && (saveBillingAddressVal =='') && state.fields.number.isEmpty && state.fields.expirationMonth.isEmpty && state.fields.expirationYear.isEmpty && state.fields.cvv.isEmpty )
				{
					allFieldValidation(ACC.ccError.allFieldsNotSelected);
				}
				
				else{
				if(state.fields.number.isEmpty && state.fields.expirationMonth.isEmpty && state.fields.expirationYear.isEmpty && state.fields.cvv.isEmpty)
				{
					hasNoError = false;
					$('.errorMessage4').show();
					$("#number").addClass("crs-error-field");
					$("#expirationMonth").addClass("crs-error-field");
					$("#expirationYear").addClass("crs-error-field");
					$("#cvv").addClass("crs-error-field");
					$('#submit_silentOrderPostForm').removeAttr("disabled");
					$(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).removeClass("disbleButtonColor");
					$('.page-loader-new-layout').hide();
					//scrollErrorMessage();
          		}
				if(state.fields.number.isEmpty) 
				{
					hasNoError = false;
					$('#submit_silentOrderPostForm').removeAttr("disabled");
					$(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).removeClass("disbleButtonColor");
					creditCardValidation(ACC.ccError.cardNumber);
					$("#number").addClass("crs-error-field");
					$('.page-loader-new-layout').hide();
				}
				if(!state.fields.number.isPotentiallyValid )
				{
					hasNoError = false;
					$('#submit_silentOrderPostForm').removeAttr("disabled");
					$(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).removeClass("disbleButtonColor");
					creditCardValidation(ACC.ccError.cardNumberInValid);
					$("#number").addClass("crs-error-field");	
					$('.page-loader-new-layout').hide();				
				}	
				if(state.fields.expirationMonth.isEmpty)
				{
					hasNoError = false;
					$('#submit_silentOrderPostForm').removeAttr("disabled");
					$(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).removeClass("disbleButtonColor");
					creditCardValidation(ACC.ccError.cardMonth);
					$("#expirationMonth").addClass("crs-error-field");
					$('.page-loader-new-layout').hide();
				}				
				if(state.fields.expirationYear.isEmpty)
				{
					hasNoError = false;
					$('#submit_silentOrderPostForm').removeAttr("disabled");
					$(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).removeClass("disbleButtonColor");
					creditCardValidation(ACC.ccError.cardYear);
					$("#expirationYear").addClass("crs-error-field");
					$('.page-loader-new-layout').hide();
				}	
				if(state.fields.cvv.isEmpty)
				{
					hasNoError = false;
					$('#submit_silentOrderPostForm').removeAttr("disabled");
					$(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).removeClass("disbleButtonColor");
					creditCardValidation(ACC.ccError.cardCVV);
					$("#cvv").addClass("crs-error-field");
					$('.page-loader-new-layout').hide();
				}				
				if(!state.fields.cvv.isPotentiallyValid)
				{
					hasNoError = false;
					$('#submit_silentOrderPostForm').removeAttr("disabled");
					$(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).removeClass("disbleButtonColor");
					creditCardValidation(ACC.ccError.cardCVVInValid);
					$("#cvv").addClass("crs-error-field");
					$('.page-loader-new-layout').hide();
				}			
				
				var billingFormErrorCounts = validateBillingAddressFields();
				var ccEnable = $('#paymentMethodBT').is(':checked');
				if(ccEnable == true && $('#savedAddresses').length > 0 && $("#savedBillingAddressId").val() == '' && $('#billing-address-form-expand').hasClass("show") == false)
				{	
					hasNoError = false;				
					var validationDiv = $('<div class="notification notification-error mb-4" />').html("Please add your billing address.");
					$('#validationMessage').append(validationDiv);
					$('.page-loader-new-layout').hide();
				}
				else if(billingFormErrorCounts > 0)
				{
					hasNoError = false;
					var validationDiv = $('<div class="notification notification-error mb-4" />').html("Please add your billing address" +
							'<a href="javascript:void(0)"  onClick="return scrollUpForError()"> Scroll up.</a>');
					$('#validationMessage').append(validationDiv);
					$('.page-loader-new-layout').hide();
					
				}
				
				
				
				function scrollErrorMessage() {
					$('html, body').animate({
						scrollTop: $(".payment-method-container").offset().top
						}, 500);
					} 
                
				if(hasNoError)
				{
					hostedFieldsInstance.tokenize(function (tokenizeErr, payload) 
					{
					    if(tokenizeErr!=null && tokenizeErr.message === "Some payment input fields are invalid. Cannot tokenize invalid card fields.")
                        {
                          let creditCardErrorMessage=document.getElementById('creditCardErrorMessage');
                          if(creditCardErrorMessage!=null)
                          {
                          tokenizeErr.message = creditCardErrorMessage.value;
                          }
                        }
						if (tokenizeErr) 
						{
						 window.mediator.publish('applyCreditCart', {
            	paymentError: tokenizeErr.message
           	});

						 hasNoError = false;
						   $('#submit_silentOrderPostForm').removeAttr("disabled");
						    creditCardValidation(tokenizeErr.message);
							$(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).removeClass("disbleButtonColor");
							$('.page-loader-new-layout').hide();
							handleClientError(tokenizeErr);	
							document.getElementById('validationMessage').scrollIntoView(true);						
						} 
						else 
						{
							var submitForm = $('#' + CONST.BRAINTREE_PAYMENT_FORM_ID);						
							var useDelivery = createHiddenParameter("use_delivery_address", $(CONST.USE_DELIVERY_ADDRESS_ID).is(HTML.CHECKED));
							var saveBillingAddress = createHiddenParameter("save_billing_address",  $('#billingAddressForm').find('input[id="save-address"]').prop("checked"));
							var savedBillingAddressId = createHiddenParameter("selected_Billing_Address_Id", $("#savedBillingAddressId").val());
							var paymentType = createHiddenParameter(CONST.PAYMENT_TYPE, payload.type);
							var cardType = createHiddenParameter(CONST.CARD_TYPE, payload.details.cardType);
							var cardDetails = createHiddenParameter(CONST.CARD_DETAILS, payload.details.lastTwo);
							var isLiabilityShifted = '';
							var paymentNonce = createHiddenParameter(CONST.PAYMENT_METHOD_NONCE, payload.nonce);
							var comapanyName = createHiddenParameter("company_name",  $('#billingAddressForm').find('input[id="address.companyName"]').val());
							var defaultCard = createHiddenParameter("default_Card",  $('#braintree-payment-form').find('input[id="default-card"]').prop("checked"));
							var orderId = createHiddenParameter("orderCode", $("#orderId").val());
							$(submitForm).find('select[name="billTo_state"]').prop('disabled', false);
							submitForm.find("input[name='billTo_country']").val("US");
							submitForm.append($(paymentNonce));
							
							if (typeof payload.liabilityShifted != 'undefined') {
								isLiabilityShifted = payload.liabilityShifted;
							}
	
							var liabilityShifted = createHiddenParameter(CONST.LIABILITY_SHIFTED, isLiabilityShifted);
							submitForm.append($(liabilityShifted));
	
							// collect device data for advanced fraud tools
							var deviceData = createHiddenParameter("device_data", this.deviceData);
							var cardholder = createHiddenParameter(CONST.CARDHOLDER, $(CONST.CARD_HOLDER_ID).val());
	
							submitForm.append($(deviceData));
							submitForm.append($(comapanyName));
							submitForm.append($(useDelivery));
							submitForm.append($(saveBillingAddress));
							submitForm.append($(savedBillingAddressId));
							submitForm.append($(paymentType));
							submitForm.append($(cardType));
							submitForm.append($(cardDetails));
							submitForm.append($(cardholder));
							submitForm.append($(defaultCard));
							submitForm.append($(orderId));
							submitForm.submit();
						}
					});
				}else{
         document.getElementById('validationMessage').scrollIntoView(true);
				}
			  }
            });
			$('.page-loader-new-layout').hide();
        }
    );
}

function validateBillingAddressFields()
{
	var errorCounts = 0;
	var savedAddressesId = $("#savedBillingAddressId").val();
	if(savedAddressesId != undefined && savedAddressesId != '' && savedAddressesId != null)
	{
		return errorCounts;
	}
	var formToValidate = $('#' + CONST.BRAINTREE_PAYMENT_FORM_ID);
	var firstName =	formToValidate.find('input[name="billTo_firstName"]');
	var lastName = formToValidate.find('input[name="billTo_lastName"]');
	var line1 = formToValidate.find('input[name="billTo_street1"]');
	var townCity = formToValidate.find('input[name="billTo_city"]');
	var postcode = formToValidate.find('input[name="billTo_postalCode"]');
	var regionIso =	formToValidate.find('select[name="billTo_state"]');
	var email = formToValidate.find('input[name="billTo_email"]');
	var phone = formToValidate.find('input[name="billTo_phoneNumber"]');
	
	if(validateField(firstName.val(),firstName) == false)
	{
		++errorCounts;
	}
	if(validateField(lastName.val(),lastName) == false)
	{
		++errorCounts;
	}
	if(validateField(line1.val(),line1) == false)
	{
		++errorCounts;
	}
	if(validateField(townCity.val(),townCity) == false)
	{
		++errorCounts;
	}
	if(validateZip(postcode.val()) == false)
	{
		postcode.addClass('error');
		++errorCounts;
	}
	if(validateField(regionIso.val(),regionIso) == false)
	{
		++errorCounts;
	}
	if(validateEmail(email.val(),email) == false)
	{
		++errorCounts;
	}
	if(validatePhone(phone.val(),phone) == false)
	{
		++errorCounts;
	}
	return errorCounts;
}

function validateZip(zipCode) 
{
    let zipRegex = /(^\d{5}$)|(^\d{5}-\d{4}$)/;
	return zipRegex.test(zipCode);
}

function validateField(attribute, fieldName) 
{
	if(attribute && attribute.trim() != '' && attribute.length < 255) 
	{
        fieldName.removeClass('error');
        return true;
    }
    fieldName.addClass('error');
    return false;
}

 function validateEmail(email, fieldName)
 {
	if(email && email.trim() != '' && null != email.match(/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/))
	{
        fieldName.removeClass('error');
        return true;
    }
    fieldName.addClass('error');
    return false;
}

function validatePhone(phone, fieldName)
{
	//if(phone && phone.trim() != '' && null != phone.match(/^[\+]?[(]?[0-9]{3}[/)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/im))
	if(phone && phone.trim() != '' && phone.length>=16)
	{
        fieldName.removeClass('error');
        return true;
    }
    fieldName.addClass('error');
    return false;
}

$("#paymentAddNewAddress").on("click",function(e)
{
	e.preventDefault();
	$('#validationMessage').empty();
	$("#allFieldvalidationMessage").empty();
	$("#save-address").prop('checked', true);
	$("#savedAddresses").html("Enter New Address");
	$("#savedBillingAddressId").val('');
	$("#paymentAddNewAddress").hide();
	$("#showSavedAddresses").hide();	
	ACC.silentorderpost.enableAddressForm();
});
$("#showSavedAddresses").on("click",function(e)
{
	e.preventDefault();
	$("#billing-address-form-expand").removeClass("show");
	$("#paymentAddNewAddress").show();
});

$('ul.selectSavedBillingAddress').on('click','li',function(e){
 	e.preventDefault();
	$('#validationMessage').empty();
	$("#allFieldvalidationMessage").empty();
	var selectedBillingAddressId = $(this).find("a").data('id');
	var selectedBillingAddressFormattedData = $(this).find("a").data('address');	
	$("#savedAddresses").html(selectedBillingAddressFormattedData);
    $('#savedAddresses').each(function() {            
        var optionText = this.text;
        var newOption = optionText.substring(0,42);
       // if(screen.width<600){
       //     var newOption = optionText.substring(0,35);
       // }
       // if(optionText > optionText.substring(0,42)){
        //    jQuery(this).text(newOption + '..');
       // }
    });
	$("#savedBillingAddressId").val(selectedBillingAddressId);
	$("#billing-address-form-expand").removeClass("show");
	$("#paymentAddNewAddress").show();
});

$('#submit_silentOrderPostForm').click(function () {
	$('#validationMessage').empty();
	$("#allFieldvalidationMessage").empty();
	var ccEnable = $('#paymentMethodBT').is(':checked');
	var giftcardApplied = $("input[name='appliedGC']").val();
	var poEnable = $('#paymentMethodPo').is(':checked');
	$("#allFieldvalidationMessage").empty();
	var savedPoForm = $("#submitSavedPoForm");
  var poNumber = savedPoForm.find('input[id="poNumber"]').val();
  var poNotes = savedPoForm.find('input[id="poNotes"]').val();
  if (poEnable == true && $.trim(poNumber) == "" && giftcardApplied == '') {     
  	var validationDiv = $(
  			'<div class="notification notification-error mb-4" />').text(
  			ACC.ccError.poNumber);
    $('#poNumber').addClass('error');       
  	$('#validationMessage').append(validationDiv);
  } else if (poEnable == true && poNumber != '' && giftcardApplied == '') {
  	savedPoForm.find('input[name="selectedPoNumber"]').val(poNumber);
  	savedPoForm.find('input[name="selectedPoNotes"]').val(poNotes);
  	savedPoForm.submit();
  }
	if(giftcardApplied == '' && ccEnable == false && poEnable != true)
	{
		allFieldValidation(ACC.ccError.allFieldsNotSelected);
	}
	
	if((typeof editPaymentMethodsPage == 'undefined') && ccEnable == false && giftcardApplied != '')
	{
		allFieldValidation(ACC.ccError.onlyGCSelected);
	}
	
	var savedCardForm = $("#submitSavedCardForm");
	var cardId = savedCardForm.find('input[id="savedCCCardId"]').val();
	var cardNonce = savedCardForm.find('input[id="savedCCCardNonce"]').val();
	
	if(ccEnable == true && cardId == '' && cardNonce == "" && $('#credit-card-form-expand').hasClass("show") == false)
	{
		creditCardValidation(ACC.ccError.cardNumber);
		creditCardValidation(ACC.ccError.cardMonth);
		creditCardValidation(ACC.ccError.cardYear);
		creditCardValidation(ACC.ccError.cardCVV);
		document.getElementById('validationMessage').scrollIntoView(true);
	}
	
	if(ccEnable == true && $('#savedAddresses').length > 0 && $("#savedBillingAddressId").val() == '' && $('#billing-address-form-expand').hasClass("show") == false)
	{		
		var validationDiv = $('<div class="notification notification-error mb-4" />').html("Please add your billing address.");
		$('#validationMessage').append(validationDiv);
	}
	else if(ccEnable == true && $("#savedBillingAddressId").val() == '')
	{
		var billingFormErrorCounts = validateBillingAddressFields();
		var validationDiv = $('<div class="notification notification-error mb-4" />').html("Please add your billing address" +
								'<a href="javascript:void(0)"  onClick="return scrollUpForError()"> Scroll up.</a>');
		$('#validationMessage').append(validationDiv);
	}
});	

function scrollUpForError()
{
	$('#billingAddressForm').find('.form-group .error')[0].scrollIntoView(true);
}

$('ul#saved-payment-action').on('click','li',function(e){
	e.preventDefault();
	var paymentId = $(this).find("button").data("id");
	var paymentnonce = $(this).find("button").data("nonce");
	if(paymentId == 'newCard')
	{
		newCardEvent(e);
		$(this).hide();
		$("#addNewCardForm").hide();
	}
	else
	{
		$('.page-loader-new-layout').show();
		var formToSubmit = $("#selectSavedCardForm");
		formToSubmit.find('input[name="selectedPaymentMethodId"]').val(paymentId);
		formToSubmit.find('input[name="selectedPaymentMethodNonce"]').val(paymentnonce);
		formToSubmit.submit();
	}	
});
$("#addNewCardForm").on("click",function(e)
{	
	newCardEvent(e);
	$("#savedCards").html("Select or Enter New Card");
	$("#savedCCCardId").val('');
	$("#savedCCCardNonce").val('');
	$("ul#saved-payment-action").find("#enterNewCardLi").hide();
	$("#addNewCardForm").unbind(EVENTS.CLICK);
});
function newCardEvent(event)
{
	$('.page-loader-new-layout').show();
	event.preventDefault();
	$("#submit_silentOrderPostForm").show();
	$("#submit_silentOrderSavedForm").hide();
	if($("#savedCCCardId") != '' && $("#savedCCCardId").val() != '')
	{
		$("#savedAddresses").html("Select or Enter New Address");
		$("#savedBillingAddressId").val('');
	}
	$("#savedCCCardId").val('');
	$("#savedCCCardNonce").val('');	
	initializeBTclientSDK();
	$(CONST.PAYMENT_METHOD_BT_ID).addClass("reInitialize");
}
$("#submit_silentOrderSavedForm").on("click",function(e)
{
	e.preventDefault();
	$('#validationMessage').empty();
	$("#allFieldvalidationMessage").empty();
	var giftcardApplied = $("input[name='appliedGC']").val();
  var poEnable = $('#paymentMethodPo').is(':checked');
  var savedPoForm = $("#submitSavedPoForm");
  var poNumber = savedPoForm.find('input[id="poNumber"]').val();
  var poNotes = savedPoForm.find('input[id="poNotes"]').val();
	$('.page-loader-new-layout').show();
	if($("#paymentMethodPayPal").is(":checked"))
	{
    ACC.track.trackPaymentSelection('PayPal Payment');
		window.location.href = ACC.config.encodedContextPath + '/checkout/multi/summary/braintree/view';
	}else if(poEnable == true && $.trim(poNumber) == "" && giftcardApplied == ''){
	  $('.page-loader-new-layout').hide();     
    var validationDiv = $('<div class="notification notification-error mb-4" />').text(ACC.ccError.poNumber);
    $('#poNumber').addClass('error'); 
    $('#validationMessage').append(validationDiv);
  }else if(poEnable == true && poNumber != '' && giftcardApplied == ''){
    ACC.track.trackPaymentSelection('PO Payment');
      savedPoForm.find('input[name="selectedPoNumber"]').val(poNumber);
      savedPoForm.find('input[name="selectedPoNotes"]').val(poNotes);     
      savedPoForm.submit();
  }
	else
	{
		var billingFormErrorCounts = validateBillingAddressFields();
		if(billingFormErrorCounts > 0)
		{
			var validationDiv = $('<div class="notification notification-error mb-4" />').html("Please add your billing address"+
								'<a href="javascript:void(0)"  onClick="return scrollUpForError()"> Scroll up.</a>');
						$('#validationMessage').append(validationDiv);
			$('.page-loader-new-layout').hide();
			document.getElementById('validationMessage').scrollIntoView(true);
		}
		else
		{
		ACC.track.trackPaymentSelection('Credit Cart Payment');
			var savedCardForm = $("#submitSavedCardForm");
			var formToSubmit = $('#' + CONST.BRAINTREE_PAYMENT_FORM_ID);
			var savedBillingAddressId = createHiddenParameter("selected_Billing_Address_Id", $("#savedBillingAddressId").val());
			var savedCCCardId = createHiddenParameter("savedCCCardId", savedCardForm.find('input[id="savedCCCardId"]').val());
			var savedCCCardNonce = createHiddenParameter("savedCCCardNonce", savedCardForm.find('input[id="savedCCCardNonce"]').val());
			var comapanyName = createHiddenParameter("company_name",  $('#billingAddressForm').find('input[id="address.companyName"]').val());
			var saveBillingAddress = createHiddenParameter("save_billing_address",  $('#billingAddressForm').find('input[id="save-address"]').prop("checked"));
			formToSubmit.find('select[name="billTo_state"]').prop('disabled', false);
			formToSubmit.find("input[name='billTo_country']").val("US");
			formToSubmit.append($(savedBillingAddressId));
			formToSubmit.append($(savedCCCardId));
			formToSubmit.append($(savedCCCardNonce));
			formToSubmit.append($(comapanyName));
			formToSubmit.append($(saveBillingAddress));
			var actionUrl = savedCardForm.attr('action');
			formToSubmit.attr('action',actionUrl);
			formToSubmit.submit();
		}
	}
});

//Handled min and max character for PO number and PO notes.
var inputQuantity = [];
$(function() {
    $(".po-number").on("keyup", function (e) {
      //  alert('tt')
        var $field = $(this),
            val=this.value;
           $thisIndex=parseInt($field.data("idx"),10); 
               if (val.length > Number($field.attr("maxlength"))) {
          val=val.slice(0, 5);
          $field.val(val);
        }
        inputQuantity[$thisIndex]=val;
    });
});


$(".edit-cc-form").on("click",function(e){
	e.preventDefault();
	
	var id = $(this).data("id");
	$("#paymentInfoId").val(id);
	$("#braintree-payment-edit-form").submit();
});

$(".js-po-extend-order").on("click", function(e) {
	e.preventDefault();
	var ccEnable = $('#paymentMethodBT').is(':checked');
	var payPalEnable = $('#paymentMethodPayPal').is(':checked');
	var poEnable = $('#paymentMethodPo').is(':checked');
	var paymentInfoId =  $('#paymentId').val();
	
	if((ccEnable == true && paymentInfoId !='') || payPalEnable == true || poEnable == true ){
	
	var extendPoNumber1 = $("#extendPoNumberInput").val();
	var extendPoNotes1 = $("#extendPoNotesInput").val();
	
	if (poEnable == true && extendPoNumber1 == '') {
		var validationDiv = $(
			'<div class="notification notification-error mb-4" />').text(
			ACC.ccError.poNumber);
	    $('#validationMessage').append(validationDiv);
		
    }else{
    	$("#extendPoNumber").val(extendPoNumber1);
		$("#extendPoNotes").val(extendPoNotes1);
   
	$("#payBillForm").submit();
    }
	}
	else{
		  allFieldValidation(ACC.ccError.allFieldsNotSelected);
		}
});




if((typeof editPaymentMethodsPage != 'undefined'))
{	
$("#submit_silentOrderPostForm").on("click",function(e) {
	e.preventDefault();
	var savedCardForm = $("#braintree-payment-form");
	var expMonth = savedCardForm.find('input[id="expirationMonth"]').val();
	var expYear = savedCardForm.find('input[id="expirationYear"]').val();
	var cvv = savedCardForm.find('input[id="cvv"]').val();
	if(expMonth == "")
	{
		hasNoError = false;
		$('#submit_silentOrderPostForm').removeAttr("disabled");
		$(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).removeClass("disbleButtonColor");
		creditCardValidation(ACC.ccError.cardMonth);
		$("#expirationMonth").addClass("crs-error-field");
		$('.page-loader-new-layout').hide();
	}
	if(expYear == "")
	{
		hasNoError = false;
		$('#submit_silentOrderPostForm').removeAttr("disabled");
		$(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).removeClass("disbleButtonColor");
		creditCardValidation(ACC.ccError.cardYear);
		$("#expirationYear").addClass("crs-error-field");
		$('.page-loader-new-layout').hide();
		
	}
	if(cvv == "")
	{
		hasNoError = false;
		$('#submit_silentOrderPostForm').removeAttr("disabled");
		$(CONST.SUBMIT_CILENT_ORDER_POST_FORM_ID).removeClass("disbleButtonColor");
		creditCardValidation(ACC.ccError.cardCVV);
		$("#cvv").addClass("crs-error-field");
		$('.page-loader-new-layout').hide();
		
	}
	if(expMonth != "" && expYear != "" && cvv !="" ){
	       var expirationDate = createHiddenParameter("expirationDate", (expMonth.concat('/', expYear)));
	       var defaultCard = createHiddenParameter("default_Card",  $('#braintree-payment-form').find('input[id="default-card"]').prop("checked"));
	       savedCardForm.append($(expirationDate));
           savedCardForm.append($(defaultCard));
           savedCardForm.submit();
	    }
});

}

$(".delete-link").on("click",function(e){
	e.preventDefault();
	
	var id = $(this).data("payment-id");
	var tokan = $(this).data("tokan");
	$("#paymentInfoIdRemove").val(id);
	$("#paymentMethodTokenRomove").val(tokan);
	
	
});

$(".js-set-default-card").on("click",function(e){
	e.preventDefault();
	var paymentInfoIdDefault = $(this).attr('data-payment-default-id');
    var paymentMethodTokenDefault = $(this).attr('data-payment-default-token');
    var defaultCard = $(this).attr('data-card-default');
    $.ajax({
        url: ACC.config.encodedContextPath + "/my-account/set-default-cc-payment-details",
        type: 'POST',
        data: {paymentInfoId: paymentInfoIdDefault},
        
        success: function (response) {
        	location.reload();
        },
        error: function (jqXHR, textStatus, errorThrown) {
              $('.modal-backdrop').addClass('remove-popup-background');
              // log the error to the console
              console.log("The following error occurred: " +jqXHR, textStatus, errorThrown);
        }
});
    
});


$(".add-cc-form").on("click",function(e){
	e.preventDefault();
	var id = $(this).data("order");
	var orderId = $("#orderId").val(id);
    $("#payment-add-form").submit();
});


$('ul#saved-payment-action-modifyPayment').on('click','li',function(e){
	 e.preventDefault();
	 
		var paymentId = $(this).find("button").data("id");
		
		var paymentnonce = $(this).find("button").data("nonce");
		
	    var buttonData = $(this).find("button").html();
	    $("#savedCards").html(buttonData);
	    $("#paymentId").val(paymentId);
		$("#paymentNonce").val(paymentnonce);
        
});


$(".js--order-modify-payment").on("click", function(e) {
	 e.preventDefault();
	 
		var ccEnable = $('#paymentMethodBT').is(':checked');
		var payPalEnable = $('#paymentMethodPayPal').is(':checked');
		var paymentInfoId =  $('#paymentId').val();
		var formToSubmit = $("#modifyPaymentForm");
		
		if((ccEnable == true && paymentInfoId !='') || payPalEnable == true){
		formToSubmit.submit();
		}
		else{
			allFieldValidation(ACC.ccError.allFieldsNotSelected);
		}
});


$(".add-cc-form-modifyPayment").on("click",function(e){
	e.preventDefault();
	var id = $(this).data("order");
	var orderId = $("#orderId").val(id);
    $("#payment-add-form-modifyPayment").submit();
});

$("#deposit-amount , #modify_order-payment-amount").on("input", function(evt) {
	$('#validationMessage').empty();
	$('#depositPaymentErrorMessage').empty();
	var self = $(this);
	self.val(self.val().replace(/[^0-9\.]/g, ''));
	if ((evt.which != 46 || self.val().indexOf('.') != -1)  && (evt.which < 48 || evt.which > 57))
	{
		evt.preventDefault();
	}
	if(self.val().indexOf('.') == 0 || self.val().split(".").length > 2)
	{
		$('#depositPaymentErrorMessage').empty();
		var validationDiv = $('<div class="notification notification-error mb-4" />').text('Enter proper amount');
		$('#depositPaymentErrorMessage').append(validationDiv);		
	}
});

$(".js-order-deposit-payment , .js-modify-order-capture-payment").on("click", function(e) {
	e.preventDefault();
	$('#validationMessage').empty();
	var ccEnable = $('#paymentMethodBT').is(':checked');
	var payPalEnable = isPayPalEnabled();
	var poEnabled = $('#paymentMethodPo').is(':checked');
	var paymentInfoId = $('#paymentId').val();
	var depositAmount = getAmount();
	if(depositAmount == '')
	{
		var validationDiv = $('<div class="notification notification-error mb-4" />').text('Please Enter Amount');
		$('#validationMessage').append(validationDiv);
	}
	else if(depositAmount.indexOf('.') == 0 || depositAmount.split(".").length > 2)
	{
		var validationDiv = $('<div class="notification notification-error mb-4" />').text('Enter proper deposit amount');
		$('#validationMessage').append(validationDiv);
	}
	else if(payPalEnable == true)
	{
		var validationDiv = $('<div class="notification notification-error mb-4" />').text('PayPal is selected. Please proceed with Paypal Payment');
		$('#validationMessage').append(validationDiv);
	}
	else if ((ccEnable == true && paymentInfoId != '')) 
	{
		$("#depositOrderTotal").val(depositAmount);
		var formToSubmit = $("#depositPaymentForm");
		formToSubmit.submit();
	}
	else if(poEnabled == true)
	{
		var formToSubmit = $("#submitModifiedOrderPoForm");
		$("#poAmount").val(depositAmount);
		formToSubmit.submit();
	}
	else 
	{
		var validationDiv = $('<div class="notification notification-error mb-4" />').text('Select payment method');
		$('#validationMessage').append(validationDiv);
	}
});

function getAmount()
{
	if($("#modify_order-payment-amount").length == 1)
	{
		return $("#modify_order-payment-amount").val();
	}
	else if($("#deposit-amount").length == 1)
	{
		return $("#deposit-amount").val();
	}
	else
	{
		return '';
	}
}

function clearErrorMessages()
{
	$('#validationMessage').empty();
	$('#depositPaymentErrorMessage').empty();
}

function isPayPalEnabled()
{
	if($("#paymentMethodPayPal-modify-order-payment").length == 1)
	{
		return $('#paymentMethodPayPal-modify-order-payment').is(':checked');
	}
	else if($("#paymentMethodPayPal").length == 1)
	{
		return $('#paymentMethodPayPal').is(':checked');
	}
	else
	{
		return false;
	}
}

$(".add-cc-form-depositPayment").on("click",function(e){
	e.preventDefault();
	var id = $(this).data("order");
	var orderId = $("#orderId").val(id);
    $("#payment-add-form-depositPayment").submit();
});

$(".js-modify-order-refund-payment").on("click", function(e) {
	e.preventDefault();
	$('#depositPaymentErrorMessage').empty();
	var depositAmount = getAmount();
	if(depositAmount == '')
	{
		var validationDiv = $('<div class="notification notification-error mb-4" />').text('Please Enter Amount');
		$('#validationMessage').append(validationDiv);
	}
	else if(depositAmount.indexOf('.') == 0 || depositAmount.split(".").length > 2)
	{
		var validationDiv = $('<div class="notification notification-error mb-4" />').text('Enter proper deposit amount');
		$('#validationMessage').append(validationDiv);
	}
	else
	{
		doProcessRefund(depositAmount, $("#orderCode").val());
	}
});

function doProcessRefund(amount, orderCode)
{
	$.ajax({
        url: ACC.config.encodedContextPath + "/my-account/refund-remaining-payment",
        async: false,
        type: 'POST',
        data: {orderCode: orderCode, refundAmount: amount},
        
        success: function (response) {
        	if(response == 'SUCCESS')
			{
				$("#refundAmount").val(amount);
				var formToSubmit = $("#refundPaymentForm");
				formToSubmit.submit();
			}
			else if(response != '')
			{
				var validationDiv = $('<div class="notification notification-error mb-4" />').text(response);
				$('#depositPaymentErrorMessage').append(validationDiv);
			}
        },
        error: function (jqXHR, textStatus, errorThrown) {
              $('.modal-backdrop').addClass('remove-popup-background');
              // log the error to the console
              console.log("The following error occurred: " +jqXHR, textStatus, errorThrown);
        }
	});
}

$("#applyModifiedGcCode").on("click", function(e) {
	e.preventDefault();
	$('#validationMessage').empty();
	var depositAmount = getAmount();
	var gcCode = $("#gcCode").val();
	if(depositAmount == '')
	{
		var validationDiv = $('<div class="notification notification-error mb-4" />').text('Please Enter Amount');
		$('#validationMessage').append(validationDiv);
	}
	else if(depositAmount.indexOf('.') == 0 || depositAmount.split(".").length > 2)
	{
		var validationDiv = $('<div class="notification notification-error mb-4" />').text('Enter proper deposit amount');
		$('#validationMessage').append(validationDiv);
	}
	else if(gcCode == '')
	{
		var validationDiv = $('<div class="notification notification-error mb-4" />').text('Enter Gift Card Code');
		$('#validationMessage').append(validationDiv);
	}
	else
	{
		$("#paymentAmount").val(depositAmount);
		var formToSubmit = $("#giftCardForm");
		formToSubmit.submit();
	}
});

$(".remove-modified-order-gift-card").on("click", function(e) {
	e.preventDefault();
	var gcCode = $(this).data("gccode");
	$("#removeGcCode").val(gcCode);
	var formToSubmit = $("#removeGiftCardForm");
	formToSubmit.submit();	
});

$("#paymentMethodPayPal-modify-order-payment").change(function () {
	/*$('.page-loader-new-layout').show();*/
	$("#mark-paypal-button").empty();
	$('#payPalErrorMessage').empty();
	var depositAmount = getAmount();
	$(".js-modify-order-capture-payment").attr("disabled",true);
	createPayPalPaymentMarkFlow(createPayPalOptions());	
	$("#paymentMethodPayPal-modify-order-payment").addClass("initialized");
	if(depositAmount == '')
	{
		var validationDiv = $('<div class="notification notification-error mb-4" />').text('Please Enter Amount');
		$('#depositPaymentErrorMessage').append(validationDiv);		
		$('.page-loader-new-layout').hide();
	}    
});

$("#paymentMethodPo").change(function () {
	$(".js-modify-order-capture-payment").attr("disabled",false);
});
