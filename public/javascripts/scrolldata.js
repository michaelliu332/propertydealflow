$(function(){
	$('#content').scrollPagination({
		'contentPage': 'http://10.90.90.107:3000/', // the page where you are searching for results
		'contentData': {}, // you can pass the children().size() to know where is the pagination
		'scrollTarget': $(window), // who gonna scroll? in this example, the full window
		'heightOffset': 10, // how many pixels before reaching end of the page would loading start? positives numbers only please
		'beforeLoad': function(){ // before load, some function, maybe display a preloader div
			$('#loading').fadeIn();	
		},
		'afterLoad': function(elementsLoaded){// after loading, some function to animate results and hide a preloader div
			 $('#loading').fadeOut();
			 var i = 0;
			 $(elementsLoaded).fadeInWithDelay();
			 if ($('#content').children().size() > 100){ // if more than 100 results loaded stop pagination (only for test)
			 	$('#nomoreresults').fadeIn();
				$('#content').stopScrollPagination();
			 }
		}
	});
	
	// code for fade in element by element with delay
	$.fn.fadeInWithDelay = function(){
		var delay = 0;
		return this.each(function(){
			$(this).delay(delay).animate({opacity:1}, 200);
			delay += 100;
		});
	};
		   
});