$("document").ready(function(){
	let focus = 0;
	$("#name").focus();
	
	$(".send").hide();
	document.addEventListener("keyup", function(e) {
		if ($(".pwd").val() !== "")
			$(".send").show();
		else
			$(".send").hide();
		if (e.keyCode === 13 && $(".name").val() != "")
		{
			$(".loading").show();
			setTimeout(() => {
				$(".loading").hide();
			}, 100);
		}
	}, false);

	document.addEventListener('click', (e)=>{
		if (e.path[0].id == "name")
			focus = 0;
		if (e.path[0].id == "pwd")
			focus = 1;
		if (focus)
			$("#pwd").focus();
		else
			$("#name").focus();
	})

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