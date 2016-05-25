//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets

$(document).ready(function(){
	$('.trending_show').on('click', function(){ 
		var title = $(this).find('p.show_title').text();
		console.log(title);
		$('#show_name').val(title);
		console.log($('#show_name').val());
		$('input#show_name').css('color', '#fff');
		$('form.new_show').submit();
	});	
});