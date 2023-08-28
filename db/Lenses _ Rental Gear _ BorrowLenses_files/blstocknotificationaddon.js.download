ACC.stocknotification = {
    _autoload: ["bindStockNotification"],
    bindStockNotification: function() {

   /* Register product to product interest for sending availability notification*/
         $(".arrival-notification").click(function(e) {
                    $('#getNotified').html("");
                    var productCode = ACC.common.encodeHtml($(this).attr("data-box-productcode"));
                    var url = encodeURI(ACC.config.encodedContextPath + "/my-account/my-stocknotification/add/" + productCode);

                   var formObject=$("#stockNotificationForm").serialize();
                  $.ajax({
                     type: "POST",
                      url: url,
                      async: true,
                   	data: formObject,
                      success: function (result) {
                     $('#getNotified').html(result);
                         setTimeout(function () {
                     	$("#getNotified").modal('show');
                     	}, 500)
                      }
                     	})
                });
                /*  Reload page to update data on page.*/
                  $('#getNotified').on('hidden.bs.modal', function () {
                  location.reload();
                   })

                   /* remove product from product interest and stop sending further notification*/
                 	$(document).on("click", ".removeInterestbtn", function (e) {
                                			e.preventDefault();

                             		var productCode = ACC.common.encodeHtml($(this).attr("data-box-productcode"));//$("span.code").text();
                                     var url = encodeURI(ACC.config.encodedContextPath + "/my-account/my-stocknotification/remove/" + productCode);

                             		$.ajax({
                             			type: "POST",
                             			url: url
                             		}).done(function(result) {
                             		    $('#getNotified').html(result);
                                                                 setTimeout(function () {
                                                             	$("#getNotified").modal('show');
                                                             	}, 500)
                             		})
                             	});
            }
};