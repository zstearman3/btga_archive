let i = 1;
let headlines = [];
  
function scrollText(headlines, i){
  $("#headline-text").text(headlines[i]["story"])
};

function setIntervalWithTurbolinks(intervalFunction, milliseconds) {
  var interval = setInterval(intervalFunction, milliseconds);

  $(document).on('turbolinks:before-cache turbolinks:before-render', function() {
    clearTimeout(interval);
  });
}

if ($('#headline-text').length > 0) {
  $.ajax({
    url: '/active_headlines',
    method: 'GET',
    async: false,
    success: function (data){
      headlines = data;
    }
  })
  $('#headline-text').text(headlines[0]["story"])
  if (headlines.length > 0) {
    setIntervalWithTurbolinks( function () {
      scrollText(headlines, i);
      if (i >= headlines.length - 1) {
        i = 0;
      } else {
        i++;
      }
    }, 5000);
  } else {
    console.log("No headline available.")
  }
}
