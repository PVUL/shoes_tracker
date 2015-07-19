$(document).ready(function() {
  setTimeout(function(){
    $('#notice_wrapper').fadeOut("slow", function() {
      $(this).remove();
    })
  }, 1500);
});
