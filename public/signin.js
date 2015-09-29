
// $(document).ready(function() {
//   $("form").submit(function() {

//       if ($("#username").val() === "") {
//           $("#u-feedback").text("Please provide your username.").css("color", "white");
//       }

//       if ($("#password").val.length < 4) {
//           $("#feedback").css("color", "green").html("Your password must be four characters or longer");
//       }

//   })
// });

$(document).ready(function() {

  function setHeight() {
    boxHeight = $('.box_full').height();
    bodyHeight = $('#body').height();
    $('#body').css('min-height', boxHeight + 200);
  };
  setHeight();
  
  $(window).resize(function() {
    setHeight();
  });

  $('#edit_profile').click(function() {
  	$('#edit_form').toggle();
  })
});