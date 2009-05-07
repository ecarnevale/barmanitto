$(document).ready(function() {
	$('#more-tweets a').click(function() {
		var offset = parseInt($('#tweets .tweet:last').attr('id').match(/tweet\-([0-9]+)/)[1]) + 1;
		$.ajax({ url: "/?offset=" + offset, cache: false, 
			beforeSend: function() { $('#more-tweets a').hide(); $('#more-tweets img').show(); },
			success:    function(html) { $('#tweets').append(html); $('#more-tweets img').hide(); $('#more-tweets a').show();}
		});
		return false;
	});
});

FB_RequireFeatures(["XFBML"], function(){
	FB.Facebook.init("228c1d88b5b2121289e88adde9447d3c", "/xd_receiver.htm");	
});