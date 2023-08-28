ACC.order = {

	_autoload: [
	    "backToOrderHistory",
	    "bindMultidProduct",
	    ["bindApplyAccountVoucher", $(".js-voucher-apply-account-btn").length != 0],
	    "bindApplyExtendOrder",
	    "bindApplyRentAgain"
	],

	backToOrderHistory: function(){
		$(".orderBackBtn > button").on("click", function(){
			var sUrl = $(this).data("backToOrders");
			window.location = sUrl;
		});
	},
	
	bindMultidProduct: function ()
	{
		// link to display the multi-d grid in read-only mode
		$(document).on("click",'.js-show-multiD-grid-in-order', function (event){
			ACC.multidgrid.populateAndShowGrid(this, event, true);
			return false;
		});

		// link to display the multi-d grid in read-only mode
		$(document).on("click",'.showMultiDGridInOrderOverlay', function (event){
			ACC.multidgrid.populateAndShowGridOverlay(this, event);
		});

	} ,

	 bindApplyAccountVoucher: function() {

   		$(".js-voucher-apply-account-btn").on("click", function(e) {
   			e.preventDefault();
   			var voucherCode = $.trim($(".js-voucher-code-text-account").val());
   			if (voucherCode != '' && voucherCode.length > 0) {
         var formValues = $('#applyVoucherForm').serialize();
   				$.ajax({
   			url: ACC.config.encodedContextPath + '/my-account/voucher/apply',
             type: "POST",
             data: formValues,
             success: function (data) {
             if(data=='success')
                    window.location.reload();
             },
             error: function (xhr, textStatus, error) {

             }
   				});
   			} else {
   				$("#errorMessages_account_voucher").removeClass("d-none");
   				$("#errorMessages_account_voucher").html("Please enter your coupon code and click apply");
   				$(".js-voucher-code-text-account").addClass("error");
   			}

   	});



   	$("#js-voucher-code-text-account").on("keypress", function(e) {
   		var code = (e.keyCode ? e.keyCode : e.which);
   		if (code == 13) {
   			var voucherCode = $.trim($(".js-voucher-code-text-account").val());
   			if (voucherCode != '' && voucherCode.length > 0) {
   				$("#applyVoucherForm").submit();
   			} else {
   				$("#errorMessages_account_voucher").removeClass("d-none");
   				$("#errorMessages_account_voucher").html("Please enter your coupon code and click apply");
   				$(".js-voucher-code-text-account").addClass("error");
   			}
   		}
   	});
   },

   bindApplyRentAgain: function() {
         		$(".js-rent-again").on("click", function(e) {
         			e.preventDefault();
         			   var orderCode = $(this).data('order-id');
         				$.ajax({
         			url: ACC.config.encodedContextPath + '/my-account/rentAgain/'+ orderCode,
                   data: orderCode,
                   success: function (data) {
                   alert(data.includes("/cart"))
                   if(data.includes("/cart")){
                    window.location.href = ACC.config.encodedContextPath + "/cart";}
                 else  {
                 $('#rentAgainPopUp').html(data);
                   setTimeout(function(){$("#rentAgainPopUp").modal('show');},500);}
                   },
                   error: function (xhr, textStatus, error) {

                   }
         				});

         	});
         },

   	 bindApplyExtendOrder: function() {
      		$(".js-extendOrder-btn").on("click", function(e) {
      			e.preventDefault();
      			   var orderCode = $(this).data('order-id');
      			alert(orderCode)
      				$.ajax({
      			url: ACC.config.encodedContextPath + '/my-account/extendOrder',
                type: "POST",
                data: formValues,
                success: function (data) {
                if(data=='success')
                       window.location.reload();
                },
                error: function (xhr, textStatus, error) {

                }
      				});

      	});

         // To enable extend order button once payment is selected
        $(document).on("click", ".js-enable-extend-button", function (e) {
        if($('#js-isAllProductExtendabe').val() === '') {
          $('.js-enable-extend-order').attr('disabled',false);
          }
        });

   	$('ul#saved-payment-action-ExtendBill').on('click','li',function(e){
   		e.preventDefault();
   		var paymentId = $(this).find("button").data("id");		
		var paymentnonce = $(this).find("button").data("nonce");
		$("#paymentId").val(paymentId);
		$("#paymentNonce").val(paymentnonce);
		if($('#js-isAllProductExtendabe').val() === '' && paymentId !== '' && paymentId !== 'undefined' && paymentnonce !== '' && paymentnonce !=='undefined' ) 
		{
			$('.js-enable-extend-order').attr('disabled',false);
		}
	});

$(".add-cc-extendOrderform").on("click",function(e){
	e.preventDefault();
	var id = $(this).data("order");
	var orderId = $("#orderId").val(id);
    $("#extend-order-payment-add-form").submit();
});


     }

};
