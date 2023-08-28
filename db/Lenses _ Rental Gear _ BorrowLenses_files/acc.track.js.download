ACC.track = {
	trackAddToCart: function (productCode, productName,productBrand,productType,productCategory,quantity)
	{
		window.mediator.publish('trackAddToCart',{
			productCode: productCode,
			productName : productName,
			quantity: quantity,
			productBrand: productBrand,
			productType : productType,
			productCategory : productCategory
		});
	},
	trackRemoveFromCart: function(productCode, productName, initialCartQuantity)
	{
		window.mediator.publish('trackRemoveFromCart',{
			productCode: productCode,
			productName: productName,
			initialCartQuantity: initialCartQuantity
		});
	},

	trackUpdateCart: function(productCode, initialCartQuantity, newCartQuantity)
	{
		window.mediator.publish('trackUpdateCart',{
			productCode: productCode,
			initialCartQuantity: initialCartQuantity,
			newCartQuantity: newCartQuantity
		});
	},

    trackShowReviewClick: function(productCode)
    {
        window.mediator.publish('trackShowReviewClick',{});
    },

    trackChangeDamageWaiver: function(productCode, damageWaiverType){
    window.mediator.publish('changeDamageWaiver',{
     productCode:productCode,
     damageWaiverType: damageWaiverType
    });
    },

    trackShippingSelection: function(shippingType,shippingOption,stockStatus){
      window.mediator.publish('continueShippingClick',{
          shippingType:shippingType,
          shippingOption: shippingOption,
          stockStatus:stockStatus
         });
    },
    trackPaymentSelection: function(paymentType){
          window.mediator.publish('continuePaymentClick',{
          paymentType:paymentType
         });
    },

    trackCustomerLocation: function(){
     var geoIpApiKey = '3a10665f133962faeb0a1d62d6ffdc34d253c8a6056e4a8d744be679';
                 var url= 'https://api.ipdata.co?api-key=' + geoIpApiKey;
                 var ccpaState = 'California';
                 	$.ajax({
                 				url:url,
                 				success: function (response) {
                          ccpaState = response.region;
                          var isRemarketingEnable ='1';
                           if(ccpaState.toLowerCase() == 'california'){
                           isRemarketingEnable='0';
                           }
                         utag.link({
                         "tealium_event"    : "user_location_track",
                          "user_location"     : '"'+ccpaState+'"',
                          "enable_remarketing" :'"'+isRemarketingEnable+'"'
                           });
                 				},
                        	error: function (e) {
                           console.log('No API key found or the number of requests exceeded for ipdata');
                          return false;
                         }
                 			})
    }
};