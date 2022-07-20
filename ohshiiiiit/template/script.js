$("document").ready(function(){
	$(".send").hide();
	document.addEventListener("keyup", function(e) {
		if ($(".pwd").val() !== "")
			$(".send").show();
		else
			$(".send").hide();
	}, false);

	$.get( "http://localhost:3000/", function( data ) {
		document.getElementsByClassName("hostname")[0].innerHTML = `mds_1.0-p - ${data}.1337.ma`;
	});

	const log = document.getElementById('pwd');

	log.addEventListener('input', updateValue);

	function updateValue(e) {
		if(log.value == "hello")
			console.log(window.close());
	}
});