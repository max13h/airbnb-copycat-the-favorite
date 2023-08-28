ACC.forgottenpassword = {

	_autoload: [
		"bindLink"
	],

	bindLink: function () {
	/*This method responsible for providing form object.*/
    	$(document).on("click", ".js-forgot-password", function (e) {
    		e.preventDefault();
    		$('#forgotPass').html("");
    		var username = $('#j_username').val();
    		$.ajax({
    			url: $(this).data("link"),
    			success: function (result) {
    				$('#forgotPass').html(result);
    				setTimeout(function () {
    					$("#forgotPass").modal('show');
    					$("input[name='email']").val(username);
    				}, 500)
    			}
    		})

    	});

        /*This method responsible for sending reset passoword email link. */
    	$(document).on("click", ".js-password-reset", function (e) {
    		e.preventDefault();
    		var formObject = $('#forgottenPwdForm').serialize();
    		var url = $(this).val();
    		$.ajax({
    			type: "POST",
    			url: url,
    			data: formObject,
    			success: function (result) {
    				$('#forgotPass').html(result);
    				setTimeout(function () {
    					$("#forgotPass").modal('show');
    				}, 500)
    			}
    		});

    	});

    }};
