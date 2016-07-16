//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets

$(document).ready(function() {
	$('.trending_show').on('click', function() { 
		var title = $(this).attr('data-name');
		$('input#show_name').val(title).css('color', '#fff');
		$('form.new_show').submit();
	});	
});

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})