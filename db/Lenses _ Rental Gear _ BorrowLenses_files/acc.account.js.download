ACC.account = {

	_autoload: [
		"accountLink"
	],

	accountLink: function () {
		/* This function is responsible for providing form object for the login popup*/
		$(document).on("click", ".js-login-popup", function (e) {
			e.preventDefault();
			var serialClick = $(this).data('click');
			var productCode = $(this).attr('data-product-code');
			$('#signIn').html("");
			if(isSessionPresent()){
			$.ajax({
				url: $(this).data("link"),
				success: function (result) {
					$('#signIn').html(result);
					$('#serialClick').val(serialClick);
					$('#serialSignUp').attr("data-serial", serialClick);
					$('.js-selected-product').val(productCode);
					$('#serialSignUp').attr("data-product-code", productCode);
					setTimeout(function(){$("#signIn").modal('show');},500);
				}
			})
			}else{
      	console.log("session not present");
        window.location.reload();
        }
		});

		/*This function is responsible for providing form object for the sign up popup*/
		$(document).on("click", ".js-signUp-popup", function (e) {
			e.preventDefault();
			var serialClick = $(this).data('serial');
			var productCode = $(this).data('product-code');
			$('#signUp').html("");
			if(isSessionPresent()){
			$.ajax({
				url: $(this).data("link"),
				success: function (result) {
					$('#signUp').html(result);
					$('#serialClickSignUP').val(serialClick);
					$('#serialSignInInstead').attr("data-click", serialClick);
					$('#bookmarkClickSignUP').val(productCode);
         	$('#serialSignInInstead').attr("data-product-code", productCode);
					setTimeout(function(){$("#signUp").modal('show');},500)
				}
			})
			}else{
       console.log("session not present");
       window.location.reload();
       }
		});

		/** Added for BL-31 to make validation for registration **/
		$(document).on("click", ".js-signUp-popup-validation", function (e) {
			e.preventDefault();
			var formValues = $('#signUppopup-validation').serialize();
			var targetUrl = $(this).val();
			if ($('#register-form-id').val() !== '' && $('#password').val() !== '' && $('#checkPwd-form-id').val() !== '') {
			if(!$("#errorMessages_sigin_errorbox").hasClass("d-none")){
            	$("#errorMessages_sigin_errorbox").addClass("d-none");
            	}
				$.ajax({
					type: "POST",
					data: formValues,
					url: targetUrl,
					success: function (response) {
				   // This code added temporary to show the error message. Once we have the user story needs to change the code accordingly
						var splitValue = '';
						if (response.startsWith("Error:")) {
							splitValue = response.split(":");
							if (splitValue.includes('register.email.invalid')) {
							if($("#errorMessages_sigin_errorbox").hasClass("d-none")){
                                  $("#errorMessages_sigin_errorbox").removeClass("d-none");
                                  }
								$("#errorMessages_sigin_email").html("Please enter a valid email");
								// BL-689: below line added
								$("#errorMessages_sigin_email").removeClass("d-none");
							}
							if (splitValue.includes('register.firstName.invalid')) {
								if($("#errorMessages_sigin_errorbox").hasClass("d-none")){
									$("#errorMessages_sigin_errorbox").removeClass("d-none");
								}
								$("#errorMessages_sigin_firstName").html("Please enter valid first name");
								// BL-689: below line added
								$("#errorMessages_sigin_pwd").removeClass("d-none");
							}
							if (splitValue.includes('register.lastName.invalid')) {
								if($("#errorMessages_sigin_errorbox").hasClass("d-none")){
									$("#errorMessages_sigin_errorbox").removeClass("d-none");
								}
								$("#errorMessages_sigin_lastName").html("Please enter valid last name");
								// BL-689: below line added
								$("#errorMessages_sigin_lastName").removeClass("d-none");
							}
							
							if (splitValue.includes('register.pwd.invalid')) {
								if($("#errorMessages_sigin_errorbox").hasClass("d-none")){
									$("#errorMessages_sigin_errorbox").removeClass("d-none");
								}
								$("#errorMessages_sigin_pwd").html("Your password needs to be at least 8 characters long");
								// BL-689: below line added
								$("#errorMessages_sigin_pwd").removeClass("d-none");
							}
							if (splitValue.includes('validation.checkPwd.equals')) {
								if($("#errorMessages_sigin_errorbox").hasClass("d-none")){
									$("#errorMessages_sigin_errorbox").removeClass("d-none");
								}
								$("#errorMessages_sigin_chkPwd").html("Your passwords did not match, please enter them again.");
								// BL-689: below line added
								$("#errorMessages_sigin_chkPwd").removeClass("d-none");
							}
						} else if (response === 'registration.error.account.exists.title') {
							if($("#errorMessages_sigin_errorbox").hasClass("d-none")){
								$("#errorMessages_sigin_errorbox").removeClass("d-none");
							}
							// BL-689: below line added
							$("#errorMessages_sigin_email").removeClass("d-none");
							$("#errorMessages_sigin_email").html("Whoops, it looks like you’re already signed up with a BorrowLenses account.");
						} else {
							
							$("#errorMessages_sigin_errorbox").addClass("d-none");
							var serialId = $('#signUppopup-validation').find('input[name="serialClickSignUP"]').val();
							var productCode = $('#signUppopup-validation').find('input[name="bookmarkClickSignUP"]').val();
							if((serialId == "" || serialId  == undefined) && (productCode == "" || productCode  == undefined))
							{
							var pageType=$('.js-page-type').val();
              if(pageType == null || pageType == undefined){
               pageType = '';
              	}
              	// Track Tealium event for successful register.
              	var userId =$('#register-form-id').val();
              	utag.link({
                   "tealium_event"    : "user_register",
                   "user_email"     : '"'+userId+'"',
                    "newRegistration" : "1"
                      });
							window.mediator.publish('registerClick',{
                   userId: userId,
                   pageType:pageType
                 });

                            if(pageType=== 'CART' && !($('.js-cart-type').val() === 'usedGear'))
                            {
                            		moveToShippingStep(e);
                            }
                            else if($('.js-cart-type').val() === 'usedGear')
                            {
                            var url = ACC.config.encodedContextPath + "/checkout/multi/delivery-method/chooseShipping";
                            window.location.href = url;
                            }
                            else{
                            location.reload();
                            }
							}else if(!(productCode == "" || productCode  == undefined)){
							addingProductToBookMark(productCode);
              $("#signUp").hide();
							}else{

								$("#doReload").val("true");
								$('.' + serialId).click();
							}	
						}
					},
					error: function (e) {
						// do nothing
					}
				});
			}
			if ($('#register-form-id').val() === '') {
				if($("#errorMessages_sigin_errorbox").hasClass("d-none")){
					$("#errorMessages_sigin_errorbox").removeClass("d-none");
				}
				$("#errorMessages_sigin_email").html("Looks like you forgot to enter your email address");
				$("#errorMessages_sigin_email").removeClass("d-none");
			} else {
				$("#errorMessages_sigin_email").html("");
				// BL-689: below line added
				$("#errorMessages_sigin_email").addClass("d-none");
			}
			if ($('#password').val() === '') {
				if($("#errorMessages_sigin_errorbox").hasClass("d-none")){
					$("#errorMessages_sigin_errorbox").removeClass("d-none");
				}
				$("#errorMessages_sigin_pwd").html("Your password needs to be at least 8 characters long");
				$("#errorMessages_sigin_pwd").removeClass("d-none");
			} else {
				$("#errorMessages_sigin_pwd").html("");
				// BL-689: below line added
				$("#errorMessages_sigin_pwd").addClass("d-none");
			}
			if ($('#checkPwd-form-id').val() === '') {
				if($("#errorMessages_sigin_errorbox").hasClass("d-none")){
					$("#errorMessages_sigin_errorbox").removeClass("d-none");
				}
				$("#errorMessages_sigin_chkPwd").html("Be sure to provide your password confirmation");
				$("#errorMessages_sigin_chkPwd").removeClass("d-none");
			} else {
				$("#errorMessages_sigin_chkPwd").html("");
				// BL-689: below line added
				$("#errorMessages_sigin_chkPwd").addClass("d-none");
			}
			
			
			if ($('#firstName').val() === '') {
				if($("#errorMessages_sigin_errorbox").hasClass("d-none")){
					$("#errorMessages_sigin_errorbox").removeClass("d-none");
				}
				$("#errorMessages_sigin_firstName").html("Please enter valid first name");
				$("#errorMessages_sigin_firstName").removeClass("d-none");
			} else {
				$("#errorMessages_sigin_firstName").html("");
				// BL-689: below line added
				$("#errorMessages_sigin_firstName").addClass("d-none");
			}
			
			
			if ($('#lastName').val() === '') {
				if($("#errorMessages_sigin_errorbox").hasClass("d-none")){
					$("#errorMessages_sigin_errorbox").removeClass("d-none");
				}
				$("#errorMessages_sigin_lastName").html("Please enter valid last name");
				$("#errorMessages_sigin_lastName").removeClass("d-none");
			} else {
				$("#errorMessages_sigin_lastName").html("");
				// BL-689: below line added
				$("#errorMessages_sigin_lastName").addClass("d-none");
			}
			
		});

		$(document).on("click", ".js-login-popup-validation", function (e) {
			e.preventDefault();
			var formValues = $('#login-popup-validation').serialize();
			var targetUrl = $(this).val();
			var isLoginError = false;
			if ($('#j_username').val() !== '' && $('#j_password').val() !== '') {
				$.ajax({
					type: "POST",
					data: formValues,
					url: targetUrl,
					success: function (response) {
					 // This code added temporary to show the error message. Once we have the user story needs to change the code accordingly
						if (response === 'login.error.account.not.found.title') {
							$("#errorMessages_login").removeClass("d-none");
							var resetPasswrdUrl = ACC.config.encodedContextPath + "/login/pw/request";
              $("#errorMessages_login").html('Your login was incorrect, ' + '<a href="#forgotPass" data-bs-dismiss="modal" class="js-forgot-password popup-reset-password" data-link="' + resetPasswrdUrl + '">reset your password</a>');
							isLoginError = true;
						} 
						else if(response === 'login.error.account.deactivate.title') 
						{
							$("#errorMessages_login").removeClass("d-none");
							$("#errorMessages_login").html(ACC.deActivateAccount.login);
							isLoginError = true;
						}
						else {
							var serialId = $('#login-popup-validation').find('input[name="serialClick"]').val();
							var productCode = $('#login-popup-validation').find('input[name="js-selected-product"]').val();
							if((serialId == "" || serialId  == undefined) && (productCode == "" || productCode == undefined))
							{
							var pageType=$('.js-page-type').val();
               if(pageType == null || pageType == undefined){
                 pageType = '';
             	}
							 window.mediator.publish('loginClick',{
                    userId: $('#j_username').val(),
                     pageType:pageType
                  });
								if(pageType=== 'CART' && !($('.js-cart-type').val() === 'usedGear'))
                                {
                                moveToShippingStep(e);
                                }
                                else if($('.js-cart-type').val() === 'usedGear')
                                {
                                var url = ACC.config.encodedContextPath + "/checkout/multi/delivery-method/chooseShipping";
                                window.location.href = url;
                                }
                                else{
                                location.reload();
                                }
							}
							
						}
					},
					complete: function(){
					if(isLoginError == false){
						var serialId = $('#login-popup-validation').find('input[name="serialClick"]').val();
						var productCode = $('#login-popup-validation').find('input[name="js-selected-product"]').val();
						if(serialId == "" || serialId  == undefined)
						{
							/*do nothing*/
						}else{
							$("#doReload").val("true");
							$('.' + serialId).click();
							$("#signIn").hide();
						}
						if(productCode == "" || productCode  == undefined)
            	{
            	/*do nothing*/
            	}else{
            	addingProductToBookMark(productCode);
            	$("#signIn").hide();
            	}
            	}
					},					
					error: function (e) {
						// do nothing
					}
				});
			} else {
				$("#errorMessages_login").removeClass("d-none");
				var resetPasswrdUrl = ACC.config.encodedContextPath + "/login/pw/request";
        $("#errorMessages_login").html('Your login was incorrect, ' + '<a href="#forgotPass" data-bs-dismiss="modal" class="js-forgot-password popup-reset-password" data-link="' + resetPasswrdUrl + '">reset your password</a>');

			}
		});

  /* [BL-694]: Changes related to checking session */
		function isSessionPresent(){
    var sessionUrl = ACC.config.encodedContextPath + '/login/isSessionPresent';
        var status = false;
           $.ajax({
                async: false,
           			url:sessionUrl,
           			success: function (result) {
                   	if(result == 'success'){
                    	status = true;
                    	}else {
                    	status = false;
                    	}
                  },
                  error:function(error){
                    console.log("Error while accessing Session"+error);
                    status = false;
                    }
                 })
                 return status;
        }

        function moveToShippingStep(e){

                           e.preventDefault();
                             	$.ajax({
                             		url: ACC.config.encodedContextPath + "/cart/checkDateAndStock",
                             		type: 'GET',
                                 success: function (response) {

                             			if (response == 'success') {
                             				var url = ACC.config.encodedContextPath + "/checkout/multi/delivery-method/chooseShipping";
                             				window.location.href = url;
                             			} else if (response == 'rentalDateNotSelected') {
                             				$('#signIn').modal('hide');
                             				$('#signUp').modal('hide');
                             				$('#cart-warning').css('display', 'block');
                             			}else{
                             			  window.location.href = ACC.config.encodedContextPath + "/cart";
                             			}
                             		},
                             		error: function (jqXHR, textStatus, errorThrown) {
                             			console.log("The following error occurred: " + jqXHR, textStatus, errorThrown);
                             		}
                             	});

        }

	}
};
