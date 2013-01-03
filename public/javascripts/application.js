  var COLOR_MAPPING = {
    0: "#82B885",
    1: "#1A4012",
    2: "#FBF4D0",
    3: "#6B364C",
    4: "#900",
    5: "",
    6: "black"
  }

      var loadVoteCounts = function(visa_country){
        $("#visa-not-required").val("Visa not Required prior to Arrival")
        $("#visa-available-on-arrival").val("Visa available on arrival")
        $("#online-application-required").val("Online Application required*")
        $("#visa-required-prior-to-arrival").val("Visa Required prior to Arrival")
        $("#restricted-travel").val("Travel Restricted/Forbidden")



      $.get("/visas", {citizen_country: $("#countries").val(), visa_country_code: visa_country}, function(data){
        $("#visa-not-required").val($("#visa-not-required").val() + " ("+ data['visa_not_required']+")")
        $("#visa-available-on-arrival").val($("#visa-available-on-arrival").val() + " ("+ data['visa_available_on_arrival']+")")
        $("#online-application-required").val($("#online-application-required").val() + " ("+ data['online_form_required']+")")
        $("#visa-required-prior-to-arrival").val($("#visa-required-prior-to-arrival").val() + " ("+ data['visa_required']+")")
        $("#restricted-travel").val($("#restricted-travel").val() + " ("+ data['travel_restricted']+")")
      })
    }
    var refreshColorsOnMap = function(){    
          var country_code = $("#countries").val();
      $("#country-spinner").attr("style", "opacity: 1")
      $.get("/countries/" + country_code, {}, function(data){
        _.each(data, function(v,k){
          data[k] = COLOR_MAPPING[data[k]];
        })
        data[country_code] = "#375FA0";
        $('#map').vectorMap('set', 'colors', data);
      $("#country-spinner").attr("style", "opacity: 0")
      })
    };
$(document).ready(function(){

    $('#submit-data-modal').modal({backdrop : true,  keyboard : true});
    loadMap();   
    $("<div id ='map-click-instruction'><h4>Click a country to add/edit data</h4></div>").insertAfter(".jvectormap-zoomin")

    $("#countries").change(function(){
      refreshColorsOnMap();
    });

    $("#visa-not-required").click(function(e){
      $("#vote").val(0); 
      submitVoteForm();
      e.preventDefault();
    })
    $("#visa-available-on-arrival").click(function(e){
      $("#vote").val(1); 
      submitVoteForm();
      e.preventDefault();
    })
    $("#online-application-required").click(function(e){
      $("#vote").val(2); 
      submitVoteForm();
      e.preventDefault();
    })
    $("#visa-required-prior-to-arrival").click(function(e){
      $("#vote").val(3); 
      submitVoteForm();
      e.preventDefault();
    })
    $("#restricted-travel").click(function(e){
      $("#vote").val(4); 
      submitVoteForm();
      e.preventDefault();
    })
    var submitVoteForm = function(){
      if (!loggedIn){
        $('#submit-data-modal').modal("hide");
        $("#signin-modal").modal({backdrop: true}); 
        $("#signin-modal").modal("show"); 
      }else{
        var url = $("#vote-form").attr("action");
        var data = $("#vote-form").serialize();
        $("#submit-data-modal").modal("hide");
        $.post(url,data, function(){
          refreshColorsOnMap();
        });
      }
    }

    $("#comment-link").click(function(){
      $("#visa-submission-form-buttons").hide()
      $("#visa-links").hide();
      $("#vote-li").removeClass("active");
      $("#links-li").removeClass("active");
      $("#comment-li").addClass("active");
      $("#visa-comments").show().addClass("active");
      var citizen_country = $("#citizen_country").val();
      var visa_country = $("#visa_country_code").val();
      $("#visa-comments").load("/votes/fb_comment?citizen_country=" + citizen_country + "&visa_country=" + visa_country, function(){
        FB.XFBML.parse();
      });
    })

    $("#vote-link").click(function(){
      $("#visa-submission-form-buttons").show()
      $("#visa-comments").hide();
      $("#visa-links").hide();
      $("#vote-li").addClass("active");
      $("#comment-li").removeClass("active");
      $("#links-li").removeClass("active");
    })

    $("#links-link").click(function(){
      $("#visa-submission-form-buttons").hide()
      $("#visa-comments").hide();
      $("#visa-links").show();
      $("#vote-li").removeClass("active");
      $("#comment-li").removeClass("active");
      $("#links-li").addClass("active");
      var citizen_country = $("#citizen_country").val();
      var visa_country = $("#visa_country_code").val();
      $("#visa-links-list").load("/links?citizen_country=" +citizen_country + "&visa_country=" + visa_country);
    })

    $("#visa-link-submit").click(function(e){
      $.post("/links",$("#visa-links-form form").serialize(), function(r){
        $("#visa-link-submission").attr("style", "opacity:1");
        $("#visa-link-submission").animate({opacity:0}, 5000)
      });
      e.preventDefault();
    })

  });

  var loadMap = function(){
    $('#map').vectorMap({hoverOpacity: .6, hoverColor: false, onRegionClick: function(_, b){ 
       loadVoteCounts(b);
       $('#submit-data-modal').modal({backdrop : true,  keyboard : true});
       $("#visa_country_code").val(b);
       $("#citizen_country").val($("#countries").val());
       $("#link_visa_country").val(b);
       $("#link_citizen_country").val($("#countries").val());
       to_country = country_code_mapping[b];
       from_country = $("#countries  option:selected").text();
       $("#from-country").text(from_country);
       $("#to-country").text(to_country);
       $("#vote-link").click();
    }});
  };
