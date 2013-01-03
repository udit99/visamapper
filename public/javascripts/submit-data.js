$(document).ready(function(){
  $("#uservisa_submit_notrequired").click(function(e){
    e.preventDefault();
    submitVisaSubmission("0");
  })

  $("#uservisa_submit_required").click(function(e){
    e.preventDefault();
    submitVisaSubmission("1");
  })

  $("#uservisa_submit_onarrival").click(function(e){
    e.preventDefault();
    submitVisaSubmission("2");
  })

  $("#uservisa_submit_online").click(function(e){
    e.preventDefault();
    submitVisaSubmission("3");
  })

  $("#uservisa_submit_forbidden").click(function(e){
    e.preventDefault();
    submitVisaSubmission("4");
  })
})

var submitVisaSubmission = function(val){
  alert("a");
    var url = $("#new_user_visa").attr("action");
    $("#_user_visaallowed").val(val);
    var seralizedForm = $("#new_user_visa").serialize();
    $.post(url, seralizedForm, function(){
      $("#submit-data-modal").modal('toggle');
      $("#flash").attr("style", "opacity:1")
      $("#flash").animate({opacity:0}, 3000)
    });
}
