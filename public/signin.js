
$(document).ready(function() {
  $("form").submit(function() {

      if ($("#username").val() === "") {
          $("#u-feedback").text("Please provide your username.").css("color", "white");
      }

      if ($("#password").val.length < 4) {
          $("#feedback").css("color", "green").html("Your password must be four characters or longer");
      }

  })
});