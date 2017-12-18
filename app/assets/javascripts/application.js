// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .


(function() {
  $(document).on('click', '.toggle-window', function(e) {
    e.preventDefault();
    var panel = $(this).parent().parent();
    var messages_list = panel.find('.messages-list');
 
    panel.find('.panel-body').toggle();
    panel.attr('class', 'panel panel-default');
 
    if (panel.find('.panel-body').is(':visible')) {
      var height = messages_list[0].scrollHeight;
      messages_list.scrollTop(height);
    }
  });
})();


$(window).scroll(function() {
    if ($(this).scrollTop() > 250) {// can be whatever, 0 refers to the top space you allow
        $('#arrow').hide();// Hide your element
    }
    else {
        $('#arrow').show();// It's just if you want to show back the element if we're back on top
    }
});

  
$( document ).ready(function(){
    $(".tile").height($("#tile1").width());
    $(".carousel").height($("#tile1").width());
    $(".item").height($("#tile1").width());
     
    $(window).resize(function() {
    if(this.resizeTO) clearTimeout(this.resizeTO);
    this.resizeTO = setTimeout(function() {
      console.log("yotimedout")
      $(this).trigger('resizeEnd');
    }, 10);
    });
    
    $(window).bind('resizeEnd', function() {
      $(".tile").height($("#tile1").width());
        $(".carousel").height($("#tile1").width());
        $(".item").height($("#tile1").width());
    });
});

$(document).ready(function() {
  $(".animsition").animsition({
    inClass: 'flip-in-y-nr',
    outClass: 'flip-out-y-nr',
    inDuration: 1500,
    outDuration: 800,
    linkElement: '.animsition-link',
    // e.g. linkElement: 'a:not([target="_blank"]):not([href^="#"])'
    loading: true,
    loadingParentElement: 'body', //animsition wrapper element
    loadingClass: 'animsition-loading',
    loadingInner: '', // e.g '<img src="loading.svg" />'
    timeout: false,
    timeoutCountdown: 5000,
    onLoadEvent: true,
    browser: [ 'animation-duration', '-webkit-animation-duration'],
    // "browser" option allows you to disable the "animsition" in case the css property in the array is not supported by your browser.
    // The default setting is to disable the "animsition" in a browser that does not support "animation-duration".
    overlay : false,
    overlayClass : 'animsition-overlay-slide',
    overlayParentElement : 'body',
    transition: function(url){ window.location.href = url; }
  });
});


