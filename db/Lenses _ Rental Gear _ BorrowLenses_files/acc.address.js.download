ACC.address = {

	_autoload: [
		"bindToChangeAddressButton",
		"bindCreateUpdateAddressForm",
		"bindSuggestedDeliveryAddresses",
		"bindCountrySpecificAddressForms",
		"showAddressFormButtonPanel",
		"bindViewAddressBook",
		"bindToColorboxClose",
		"showRemoveAddressFromBookConfirmation",
		"backToListAddresses",
		"bindSettingDefaultAddress"
	],

	spinner: $("<img src='" + ACC.config.commonResourcePath + "/images/spinner.gif' />"),
	addressID: '',

	handleChangeAddressButtonClick: function ()
	{


		ACC.address.addressID = ($(this).data("address")) ? $(this).data("address") : '';
		$('#summaryDeliveryAddressFormContainer').show();
		$('#summaryOverlayViewAddressBook').show();
		$('#summaryDeliveryAddressBook').hide();


		$.getJSON(getDeliveryAddressesUrl, ACC.address.handleAddressDataLoad);
		return false;
	},

	handleAddressDataLoad: function (data)
	{
		ACC.address.setupDeliveryAddressPopupForm(data);

		// Show the delivery address popup
		ACC.colorbox.open("",{
		 	inline: true,
			href: "#summaryDeliveryAddressOverlay",
			overlayClose: false,
			onOpen: function (){
				// empty address form fields
				ACC.address.emptyAddressForm();
				$(document).on('change', '#saveAddress', function ()
				{
					var saveAddressChecked = $(this).prop('checked');
					$('#defaultAddress').prop('disabled', !saveAddressChecked);
					if (!saveAddressChecked)
					{
						$('#defaultAddress').prop('checked', false);
					}
				});
			}
		});

	},

	setupDeliveryAddressPopupForm: function (data)
	{
		// Fill the available delivery addresses
		$('#summaryDeliveryAddressBook').html($('#deliveryAddressesTemplate').tmpl({addresses: data}));
		// Handle selection of address
		$('#summaryDeliveryAddressBook button.use_address').click(ACC.address.handleSelectExistingAddressClick);
		// Handle edit address
		$('#summaryDeliveryAddressBook button.edit').click(ACC.address.handleEditAddressClick);
		// Handle set default address
		$('#summaryDeliveryAddressBook button.default').click(ACC.address.handleDefaultAddressClick);
	},

	emptyAddressForm: function ()
	{
		var options = {
			url: getDeliveryAddressFormUrl,
			data: {addressId: ACC.address.addressID, createUpdateStatus: ''},
			type: 'GET',
            dataType: 'html',
			success: function (data)
			{
				$('#summaryDeliveryAddressFormContainer').html(data);
				ACC.address.bindCreateUpdateAddressForm();
			}
		};

		$.ajax(options);
	},

	handleSelectExistingAddressClick: function ()
	{
		var addressId = $(this).attr('data-address');
		$.postJSON(setDeliveryAddressUrl, {addressId: addressId}, ACC.address.handleSelectExitingAddressSuccess);
		return false;
	},

	handleEditAddressClick: function ()
	{

		$('#summaryDeliveryAddressFormContainer').show();
		$('#summaryOverlayViewAddressBook').show();
		$('#summaryDeliveryAddressBook').hide();

		var addressId = $(this).attr('data-address');
		var options = {
			url: getDeliveryAddressFormUrl,
			data: {addressId: addressId, createUpdateStatus: ''},
			target: '#summaryDeliveryAddressFormContainer',
			type: 'GET',
			success: function (data)
			{
				ACC.address.bindCreateUpdateAddressForm();
				ACC.colorbox.resize();
			},
			error: function (xht, textStatus, ex)
			{
				console.log("Failed to update cart. Error details [" + xht + ", " + textStatus + ", " + ex + "]");  // NOSONAR
			}
		};

		$(this).ajaxSubmit(options);
		return false;
	},

	handleDefaultAddressClick: function ()
	{
		var addressId = $(this).attr('data-address');
		var options = {
			url: setDefaultAddressUrl,
			data: {addressId: addressId},
			type: 'GET',
			success: function (data)
			{
				ACC.address.setupDeliveryAddressPopupForm(data);
			},
			error: function (xht, textStatus, ex)
			{
				console.log("Failed to update address book. Error details [" + xht + ", " + textStatus + ", " + ex + "]");  // NOSONAR
			}
		};

		$(this).ajaxSubmit(options);
		return false;
	},

	handleSelectExitingAddressSuccess: function (data)
	{
		if (data != null)
		{
			ACC.refresh.refreshPage(data);
			ACC.colorbox.close();
		}
		else
		{
			console.log("Failed to set delivery address");  // NOSONAR
		}
	},

	bindCreateUpdateAddressForm: function ()
	{
		$('.create_update_address_form').each(function ()
		{
			var options = {
				type: 'POST',
				beforeSubmit: function ()
				{
					$('#checkout_delivery_address').block({ message: ACC.address.spinner });
				},
				success: function (data)
				{
					$('#summaryDeliveryAddressFormContainer').html(data);
					var status = $('.create_update_address_id').attr('status');
					if (status != null && "success" === status.toLowerCase())
					{
						ACC.refresh.getCheckoutCartDataAndRefreshPage();
						ACC.colorbox.close();
					}
					else
					{
						ACC.address.bindCreateUpdateAddressForm();
						ACC.colorbox.resize();
					}
				},
				error: function (xht, textStatus, ex)
				{
					console.log("Failed to update cart. Error details [" + xht + ", " + textStatus + ", " + ex + "]");  // NOSONAR
				},
				complete: function ()
				{
					$('#checkout_delivery_address').unblock();
				}
			};

			$(this).ajaxForm(options);
		});
	},

	refreshDeliveryAddressSection: function (data)
	{
		$('.summaryDeliveryAddress').replaceWith($('#deliveryAddressSummaryTemplate').tmpl(data));

	},

	bindSuggestedDeliveryAddresses: function ()
	{
		var status = $('.add_edit_delivery_address_id').attr('status');
		if (status != null && "hasSuggestedAddresses" == status)
		{
			ACC.address.showSuggestedAddressesPopup();
		}
	},

	showSuggestedAddressesPopup: function ()
	{
		$(document).ready(function(){
			ACC.colorbox.open("Suggested Addresses",{
				href: "#popup_suggested_delivery_addresses",
				inline: true,
				width:"525px",
				onComplete: function ()
				{
					$(this).colorbox.resize();
				}
			});
			
		})	
	},

	bindCountrySpecificAddressForms: function (){
		$(document).on("change",'#countrySelector select', function (){
			var options = {
				'addressCode': '',
				'countryIsoCode': $(this).val()
			};
			ACC.address.displayCountrySpecificAddressForm(options, ACC.address.showAddressFormButtonPanel);
		})

	},

	showAddressFormButtonPanel: function ()
	{
		if ($('#countrySelector :input').val() !== '')
		{
			$('#addressform_button_panel').show();
		}
	},

	bindToColorboxClose: function ()
	{
		$(document).on("click", ".closeColorBox", function ()
		{
			ACC.colorbox.close();
		})
	},


	displayCountrySpecificAddressForm: function (options, callback)
	{
		$.ajax({
			url: ACC.config.encodedContextPath + '/my-account/addressform',
			async: true,
			data: options,
			dataType: "html",
			beforeSend: function ()
			{
				$("#i18nAddressForm").html(ACC.address.spinner);
			}
		}).done(function (data)
				{
					$("#i18nAddressForm").html($(data).html());
					if (typeof callback == 'function')
					{
						callback.call();
					}
				});
	},

	bindToChangeAddressButton: function ()
	{
		$(document).on("click", '.summaryDeliveryAddress .editButton', ACC.address.handleChangeAddressButtonClick);
	},

	bindViewAddressBook: function ()
	{

		$(document).on("click",".js-address-book",function(e){
			e.preventDefault();

			ACC.colorbox.open("Saved Addresses",{
				href: "#addressbook",
				inline: true,
				width:"380px"
			});
			
		})

		
		$(document).on("click", '#summaryOverlayViewAddressBook', function ()
		{
			$('#summaryDeliveryAddressFormContainer').hide();
			$('#summaryOverlayViewAddressBook').hide();
			$('#summaryDeliveryAddressBook').show();
			ACC.colorbox.resize();
		});
	},
	
	showRemoveAddressFromBookConfirmation: function ()
	{
		$(document).on("click", ".removeAddressFromBookButton", function ()
		{
			var addressId = $(this).data("addressId");
			document.getElementById("removeAddressLink").href = "remove-address/"+addressId;
		})
	},

	backToListAddresses: function(){
		$(".addressBackBtn").on("click", function(){
			var sUrl = $(this).data("backToAddresses");
			window.location = sUrl;
		});
	},
	bindSettingDefaultAddress :function(){
    	$(document).on("click", ".js-set-default-address", function (e)
                {
                $("#js-add-address-length-Validation").empty();
                $("#js-add-address-Validation").empty();
                $("#js-default-address-Validation").empty();
                  var url = $(this).val();
                     $.ajax({
                    	url: url,
                    	success: function (result) {
                    	location.reload();
                    	}
                    	});
                });

           /* This method is written for address form validation*/
           var count = 0;
           $(document).on("click", ".js-validate-address-form-data", function (e) {
           	e.preventDefault();
           	count = 0;
           	$('#js-add-address-Validation').html("");
           	$('#js-add-address-Validation').removeClass('notification notification-error');
           	$("#js-add-address-length-Validation").empty();
           	$("#js-add-address-length-Validation").removeClass('notification notification-error');
                $("#js-add-address-Validation").empty();
                $("#js-default-address-Validation").empty();

           	// Fetching input form object.
           	var firstName = $('.accountAddressAdd #editAddress').find('.form-group').find('input[id="address.firstName"]');
           	var lastName = $('.accountAddressAdd #editAddress').find('.form-group').find('input[id="address.surname"]');
           	var line1 = $('.accountAddressAdd #editAddress').find('.form-group').find('input[id="address.line1"]');
           	var townCity = $('.accountAddressAdd #editAddress').find('.form-group').find('input[id="address.townCity"]');
           	var postcode = $('.accountAddressAdd #editAddress').find('.form-group').find('input[id="zip"]');
           	var regionIso = $('.accountAddressAdd #editAddress').find('.form-group').find('select[id="state"]');
           	var email = $('.accountAddressAdd #editAddress').find('.form-group').find('input[id="address.email"]');
           	var phone = $('.accountAddressAdd #editAddress').find('.form-group').find('input[id="address.phone"]');
             //Validating form data
           	validateField(firstName.val(), firstName);
           	validateField(lastName.val(), lastName);
           	validateField(line1.val(), line1);
           	validateField(townCity.val(), townCity);
           	validateField(postcode.val(), postcode);
           	validateField(regionIso.val(), regionIso);
           	validateEmail(email.val(), email);
           	validatePhone(phone.val(), phone);
           	let checkedStatus = false;
           	var billing = $('#default-billing-address').is(':checked');
           	var shipping = $('#default-shipping-address').is(':checked');
           	if (billing || shipping) {
           		$('#js-default-address-Validation').removeClass('notification notification-error');
           		$('#js-default-address-Validation').html("");
           		checkedStatus = true;
           	} else {
           		$('#js-default-address-Validation').addClass('notification notification-error');
           		$('#js-default-address-Validation').html("Whoops, be sure to select if this is a billing or shipping address.");
           	}
           	if(validateFirstNameAndLastName(firstName, lastName))
           	{
           		var errorMsg = 'Combined length of First Name and Last Name should not be more than 48 characters';
           		$('#js-add-address-length-Validation').addClass('notification notification-error');
              	$('#js-add-address-length-Validation').html(errorMsg);
    			$('#js-add-address-length-Validation').show();
    			checkedStatus = false;
           	}
           	if (count > 0) {
           		$('#js-add-address-Validation').addClass('notification notification-error');
           		$('#js-add-address-Validation').html("You are missing " + count + " required fields.");
           	} else if (checkedStatus) {
           		$('#editAddress').submit();
           	}
           });
           
           function validateFirstNameAndLastName(firstName, lastName)
		  {
		  	var isValid = false;
		  	var flen = firstName.val().length;
		  	var llen = lastName.val().length;
		  	
		  	var totalLength = flen + llen;
		  	
		  	if(totalLength > 48)
		  	{
		  		firstName.addClass('error');
		  		lastName.addClass('error');
		  		firstName.addClass('lengthError');
		  		lastName.addClass('lengthError');
		  		isValid = true;
		  	}
		  	else
		  	{
		  		firstName.removeClass('lengthError');
		  		lastName.removeClass('lengthError');
		  		isValid = false;
		  	}
		  	return isValid;
		  }

        /*Validating address field */
    	function validateField(attribute, fieldName) {
        	if (attribute && attribute.trim() != '' && attribute.length < 255) {
        		fieldName.removeClass('error');
        		return true;
        	}
        	fieldName.addClass('error');
        	count = count + 1;
        	return false;
        }
        /* Validate email data*/
        function validateEmail(email, fieldName) {
        	if (email && email.trim() != '' && null != email.match(/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/)) {
        		fieldName.removeClass('error');
        		return true;
        	}
        	fieldName.addClass('error');
        	count = count + 1;
        	return false;
        }
        /*Validating phone number*/
         function validatePhone(phone, fieldName) {
        	//if (phone && phone.trim() != '' && null != phone.match(/^[\+]?[(]?[0-9]{3}[/)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/im)) {
     	if(phone && phone.trim() != '' && phone.length>=16){
        		fieldName.removeClass('error');
        		return true;
        	}
        	fieldName.addClass('error');
        	count = count + 1;
        	return false;
        }

    	}

};
