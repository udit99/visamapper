$(document).ready(function(){
  $.getJSON('http://api.wipmania.com/jsonp?callback=?',
                                   '', function(json) {
    $('select#countries option[value='
                 + json.address.country_code.toLowerCase() + ']')
                 .attr('selected', 'selected');
    $("select#countries").trigger("change")
    });
})

