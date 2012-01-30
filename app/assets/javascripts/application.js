// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

$(function(){
  $("form.settings input[type='radio']").click(function(){
    $(this).closest('form').submit();
  });

  $("form.settings input[type='text']").change(function(){
    $(this).closest('form').submit();
  });

  $("form#upload input[type='file']").change(function(){
    $(this).closest('form').submit();
  });

  $(".clear-queue-link").click(function(){
    _self = $(this);
    _self.html('Clearing...').attr('disabled', 'disabled');
    $.ajax({
      url: '/jobs/clear.js',
      type: 'POST',
      success: function() { _self.html('Clear queue').removeAttr('disabled') }
    })
  });
});