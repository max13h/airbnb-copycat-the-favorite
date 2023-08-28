ACC.autocomplete = {

	_autoload: [
		"bindSearchAutocomplete",
        "bindDisableSearch"
	],

	bindSearchAutocomplete: function ()
	{
		// extend the default autocomplete widget, to solve issue on multiple instances of the searchbox component
		$.widget( "custom.yautocomplete", $.ui.autocomplete, {
			_create:function(){
				
				// get instance specific options form the html data attr
				var option = this.element.data("options");
				// set the options to the widget
				this._setOptions({
					minLength: option.minCharactersBeforeRequest,
					displayProductImages: option.displayProductImages,
					delay: option.waitTimeBeforeRequest,
					autocompleteUrl: option.autocompleteUrl,
					source: this.source
				});
				
				// call the _super()
				$.ui.autocomplete.prototype._create.call(this);
				
			},
			options:{
				cache:{}, // init cache per instance
				focus: function (){return false;}, // prevent textfield value replacement on item focus
				select: function (event, ui){
					ui.item.value = ACC.sanitizer.sanitizeSelect(ui.item.value);
                    window.location.href = ui.item.url;
                }
			},
			_renderItem : function (ul, item){
				
				if (item.type == "autoSuggestion"){
					var blPageType = document.getElementById("js-page-type").value;
				  var completeUrl = item.url + "&blPageType="+ blPageType +"&text=";
					var renderHtml = $("<a>").attr("href", completeUrl)
							.append($("<div>").addClass("name").text(item.value));
					return $("<li>")
							.data("item.autocomplete", item)
							.append(renderHtml)
							.appendTo(ul);
				}
				else if (item.type == "productResult"){
					var renderHtml = $("<a>").attr("href", item.url)
							.append(
									item.image  
											? $("<div>").addClass("thumb")
													.append($("<img>").attr("src", item.image))
											: null
							)
							.append($("<div>").addClass("name").html(ACC.sanitizer.sanitize(item.value)))
							.append($("<div>").addClass("price").text(item.price));

					return $("<li>")
							.data("item.autocomplete", item)
							.append(renderHtml)
							.appendTo(ul);
				}
			},
			source: function (request, response)
			{
				var self=this;
				var term = request.term.toLowerCase();
				var blPageType = document.getElementById("js-page-type").value;
				if (term in self.options.cache)
				{
					return response(self.options.cache[term]);
				}

				$.getJSON(self.options.autocompleteUrl, {term: request.term ,blPageType:blPageType}, function (data)
				{
					var autoSearchData = [];
					if(data.suggestions != null){
						$.each(data.suggestions, function (i, obj)
						{
							autoSearchData.push({
								value: obj.term,
								url: ACC.config.encodedContextPath + "/search?text=" + encodeURIComponent(obj.term),
								type: "autoSuggestion"
							});
						});
					}
					if(data.products != null){
					var blPageType = document.getElementById("js-page-type").value;
				 var productUrl = "";
					if(blPageType ==='usedGear') {
					productUrl = "/buy";
					}
					else {
					productUrl = "/rent";
					}
						$.each(data.products, function (i, obj)
						{
							autoSearchData.push({
								value: ACC.sanitizer.sanitize(obj.name),
								code: obj.code,
								desc: ACC.sanitizer.sanitize(obj.description),
								manufacturer: ACC.sanitizer.sanitize(obj.manufacturer),
								url:  ACC.config.encodedContextPath + productUrl + obj.url,
								/*price: obj.price.formattedValue,*/
								type: "productResult",
								image: (obj.images!=null && self.options.displayProductImages) ? obj.images[0].url : null // prevent errors if obj.images = null
							});
						});
					}
					self.options.cache[term] = autoSearchData;
					return response(autoSearchData);
				});
			}

		});

	
		$search = $(".js-site-search-input");
		if($search.length>0){
			$search.yautocomplete()
		}

		/** Added unique class for mobile search box**/
			$search2 = $(".js-site-search-input-mobile");
        		if($search2.length>0){
        			$search2.yautocomplete()
        		}

	},

	bindDisableSearch: function ()
    {
        $('#js-site-search-input').keyup(function(){
        	$('#js-site-search-input').val($('#js-site-search-input').val().replace(/^\s+/gm,''));
        })

        /**Added unique id for Mobile Search Box**/
          $('#js-site-search-input-mob').keyup(function(){
                        	$('#js-site-search-input-mob').val($('#js-site-search-input-mob').val().replace(/^\s+/gm,''));
                        })
    }
};