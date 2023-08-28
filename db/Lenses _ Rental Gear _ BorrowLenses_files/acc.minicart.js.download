ACC.minicart = {

	_autoload: [
		"bindMiniCart"
	],

	bindMiniCart: function(){

		$(document).on("click",".js-mini-cart-link", function(e){
			e.preventDefault();
			var url = $(this).data("miniCartUrl");
			var cartName = ($(this).find(".js-mini-cart-count").html() != 0) ? $(this).data("miniCartName"):$(this).data("miniCartEmptyName");

			ACC.colorbox.open(ACC.common.encodeHtml(cartName),{
				href: url,
				maxWidth:"100%",
				width:"380px",
				initialWidth :"380px"
			});
		});

		$(document).on("click",".js-mini-cart-close-button", function(e){
			e.preventDefault();
			ACC.colorbox.close();
		});
	},

	updateMiniCartDisplay: function(){
  		var miniCartRefreshUrl = $(".bak_js-mini-cart-link").data("miniCartRefreshUrl");
  		$.ajax({
  			url: miniCartRefreshUrl,
  			cache: false,
  			type: 'GET',
  			dataType: 'json',
  			success: function(jsonData){
  				var $numberItem = $("<span>").addClass("nav-items-total").text(jsonData.miniCartCount);
  				$(".bak_js-mini-cart-link .cart-count").empty();
  				$(".bak_js-mini-cart-link .cart-count").append($numberItem);
  			 }
  		});
  }

};