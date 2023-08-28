 var bookmarkicons = document.querySelectorAll(".bookmarkicons");
               console.log(bookmarkicons.length);
                  for(var i=0;i<bookmarkicons.length;i++){
                         bookmarkicons[i].id ="bookmarkicons-"+(i+1);
                          }


              $(document).on('click',".js-add-to-wishlist", function(e) {
                                      e.preventDefault();
                                       var bookmarkId =this.getAttribute("id");
                                       console.log(bookmarkId);
                                        var productCode = $(this).attr('data-product-code');
                                        var targetAddUrl    = ACC.config.encodedContextPath + "/wishlist/add"
                                        var targetRemoveUrl = ACC.config.encodedContextPath + "/removewishlist"
                                        var bookmarkValue = $(this).attr('data-bookmark-value');
                                        if((document.getElementById(bookmarkId).classList.contains("set")))
                                        {
                                        $.ajax({
                                                       url: targetRemoveUrl,
                                                       type: 'POST',
                                                       data: {removeproductCode: productCode},
                                                       success: function (response) {
                                                       if(response === 'Success'){
                                                        document.getElementById(bookmarkId).classList.remove("set");
                                                       }
                                                       else{
                                                       console.log("found error while removing the product");
                                                       }

                                                         },
                                                       error: function (jqXHR, textStatus, errorThrown) {
                                                           console.log("The following error occurred: " +jqXHR, textStatus, errorThrown);
                                                        }
                                                 });

                                        }
                                        else{
                                       $.ajax({
                                          url: targetAddUrl,
                                          type: 'GET',
                                          data: {productwishlistCode: productCode},
                                          success: function (response) {
                                          if(response === 'Success'){
                                           document.getElementById(bookmarkId).classList.add("set");
                                          }
                                          else{
                                          console.log("found error while adding product to wishlist");
                                          }
                                            },
                                          error: function (jqXHR, textStatus, errorThrown) {
                                              console.log("The following error occurred: " +jqXHR, textStatus, errorThrown);
                                           }
                                       });
                                     }
                });

function addingProductToBookMark(productCode) {
	var targetAddUrl = ACC.config.encodedContextPath + "/wishlist/add"
	$.ajax({
		url: targetAddUrl,
		type: 'GET',
		data: {
			productwishlistCode: productCode
		},
		success: function (response) {
				location.reload();
		},
		error: function (jqXHR, textStatus, errorThrown) {
			console.log("The following error occurred: " + jqXHR, textStatus, errorThrown);
		}
	});
}
