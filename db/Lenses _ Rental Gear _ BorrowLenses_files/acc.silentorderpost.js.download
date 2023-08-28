ACC.silentorderpost = {

	spinner: $("<img>").attr("src", ACC.config.commonResourcePath + "/images/spinner.gif").addClass("spiner-select"),

	bindUseDeliveryAddress: function ()
	{
		$('#ccUseDeliveryAddress').on('change', function ()
		{
			if ($('#ccUseDeliveryAddress').is(":checked"))
			{
				var options = {'countryIsoCode': $('#useDeliveryAddressData').data('countryisocode'), 'useDeliveryAddress': true};
				ACC.silentorderpost.enableAddressForm();
				ACC.silentorderpost.displayCreditCardAddressForm(options, ACC.silentorderpost.useDeliveryAddressSelected);
				$("#save-address").prop('checked', true);
				$('.hideUseShipping').hide();
				ACC.silentorderpost.enableReadOnlyAddressForm();
			}
			else
			{
				ACC.silentorderpost.clearAddressForm();
				ACC.silentorderpost.enableAddressForm();
				$("#save-address").prop('checked', true);
				$('.hideUseShipping').hide();
				ACC.silentorderpost.disableReadOnlyAddressForm();
				const inputElement = document.getElementById('address.phone');
        		if (inputElement != null) {
        			inputElement.addEventListener('keydown', enforceBillingFormFormat);
        			inputElement.addEventListener('keyup', formatToPhoneForBillingForm);
        			inputElement.addEventListener('change',formatToPhoneForBillingForm);
        		}
        const inputZipElement = document.getElementById('address.postcode');
        		if(inputZipElement !=null)
        		{
                inputZipElement.addEventListener('keydown', enforceBillingFormFormat);
        		}
			}
		});

const isNumericInput = (event) => {
    const key = event.keyCode;
    return ((key >= 48 && key <= 57) || // Allow number line
        (key >= 96 && key <= 105) // Allow number pad
    );
};

const isModifierKey = (event) => {
    const key = event.keyCode;
    return (event.shiftKey === true || key === 35 || key === 36) || // Allow Shift, Home, End
        (key === 8 || key === 9 || key === 13 || key === 46) || // Allow Backspace, Tab, Enter, Delete
        (key > 36 && key < 41) || // Allow left, up, right, down
        (
            // Allow Ctrl/Command + A,C,V,X,Z
            (event.ctrlKey === true || event.metaKey === true) &&
            (key === 65 || key === 67 || key === 86 || key === 88 || key === 90)
        )
};

		const enforceBillingFormFormat = (event) => {
        // Input must be of a valid number format or a modifier key, and not longer than ten digits
        if(!isNumericInput(event) && !isModifierKey(event)){
            event.preventDefault();
        }
    };

    const formatToPhoneForBillingForm= (event) => {
        if(isModifierKey(event)) {return;}

        const input = event.target.value.replace(/\D/g,'').substring(0,10); // First ten digits of input only
        const areaCode = input.substring(0,3);
        const middle = input.substring(3,6);
        const last = input.substring(6,10);

        if(input.length > 6){event.target.value = `(${areaCode}) ${middle} - ${last}`;}
        else if(input.length > 3){event.target.value = `(${areaCode}) ${middle}`;}
        else if(input.length > 0){event.target.value = `(${areaCode}`;}
    };



		if ($('#ccUseDeliveryAddress').is(":checked"))
		{
			var options = {'countryIsoCode': $('#useDeliveryAddressData').data('countryisocode'), 'useDeliveryAddress': true};
			ACC.silentorderpost.enableAddressForm();
			ACC.silentorderpost.displayCreditCardAddressForm(options, ACC.silentorderpost.useDeliveryAddressSelected);
			$("#save-address").prop('checked', true);
			$('.hideUseShipping').hide();
			ACC.silentorderpost.disableAddressForm();
			
		}
		else
		{
			var options = {'countryIsoCode': $('#useDeliveryAddressData').data('countryisocode'), 'useDeliveryAddress': false};
			ACC.silentorderpost.displayCreditCardAddressForm(options, ACC.silentorderpost.useDeliveryAddressSelected);
			ACC.silentorderpost.enableAddressForm();
			$("#save-address").prop('checked', true);
			$('.hideUseShipping').hide();
			ACC.silentorderpost.disableReadOnlyAddressForm();
		}
	},

	bindSubmitSilentOrderPostForm: function ()
	{
		$('.submit_silentOrderPostForm').click(function ()
		{
			ACC.common.blockFormAndShowProcessingMessage($(this));
			$('.billingAddressForm').filter(":hidden").remove();
			ACC.silentorderpost.enableAddressForm();
			$('#silentOrderPostForm').submit();
		});
	},

	bindCycleFocusEvent: function ()
	{
		$('#lastInTheForm').blur(function ()
		{
			$('#silentOrderPostForm [tabindex$="10"]').focus();
		})
	},

	isEmpty: function (obj)
	{
		if (typeof obj == 'undefined' || obj === null || obj === '') return true;
		return false;
	},

	disableAddressForm: function ()
	{
		$('input[id^="address\\."]').prop('disabled', true);
		$('select[id^="address\\."]').prop('disabled', true);
	},
	
	enableReadOnlyAddressForm: function ()
	{
		$('input[id^="address\\."]').prop('readOnly', true);
		$('select[id^="address\\."]').prop('disabled', true);
	},
	
	disableReadOnlyAddressForm: function ()
	{
		$('input[id^="address\\."]').prop('readOnly', false);
		$('select[id^="address\\."]').prop('disabled', false);
	},

	enableAddressForm: function ()
	{
		$('input[id^="address\\."]').prop('disabled', false);
		$('select[id^="address\\."]').prop('disabled', false);
	},

	clearAddressForm: function ()
	{
		$('input[id^="address\\."]').val("");
		$('select[id^="address\\."]').val("");
	},

	useDeliveryAddressSelected: function ()
	{
		if ($('#ccUseDeliveryAddress').is(":checked"))
		{
			var countryIsoCode = $('#address\\.country').val($('#useDeliveryAddressData').data('countryisocode')).val();
			if(ACC.silentorderpost.isEmpty(countryIsoCode))
			{
				$('#ccUseDeliveryAddress').click();
				$('#ccUuseDeliveryAddress').parent().hide();
			}
			else
			{
				$("#save-address").prop('checked', true);
				$('.hideUseShipping').hide();
				ACC.silentorderpost.enableReadOnlyAddressForm();
			}
		}
		else
		{
			ACC.silentorderpost.clearAddressForm();
			ACC.silentorderpost.enableAddressForm();
			$("#save-address").prop('checked', true);
			$('.hideUseShipping').hide();
			ACC.silentorderpost.disableReadOnlyAddressForm();
		}
	},
	
	

	bindCreditCardAddressForm: function ()
	{
		$('#billingCountrySelector :input').on("change", function ()
		{
			var countrySelection = $(this).val();
			var options = {
				'countryIsoCode': countrySelection,
				'useDeliveryAddress': false
			};
			ACC.silentorderpost.displayCreditCardAddressForm(options);
		})
	},

	displayCreditCardAddressForm: function (options, callback)
	{
		$.ajax({ 
			url: ACC.config.encodedContextPath + '/checkout/multi/sop/billingaddressform',
			async: true,
			data: options,
			dataType: "html",
			beforeSend: function ()
			{
				$('#billingAddressForm').html(ACC.silentorderpost.spinner);
			}
		}).done(function (data)
				{
					$("#billingAddressForm").html(data);
					if (typeof callback == 'function')
					{
						callback.call();
					}
				});
	}
}

$(document).ready(function ()
{
	ACC.silentorderpost.bindUseDeliveryAddress();
	ACC.silentorderpost.bindSubmitSilentOrderPostForm();
	ACC.silentorderpost.bindCreditCardAddressForm();
	$('.hideUseShipping').hide();
	// check the checkbox
	$("#useDeliveryAddress").click();
});
