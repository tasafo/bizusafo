$(document).ready(function() {
  $("span.positive-votes a").on("click", { signal: '+' }, ratingStory);
  $("span.negative-votes a").on("click", { signal: '-' }, ratingStory);

  $(".filters select").on("change", filterStories);

  $('.sign-in-to-rate').popover({ html: true, container: "body" });
  $('.popover-trigger').popover({ container: "body" });
});

function filterStories(e){
  e.preventDefault();

  var filter = $(".filters select[name='filter']").val();
  var order = $(".filters select[name='order']").val();
  var tags = $(".filters input[name='tags']").val();

  var data = {};

  data["filter"] = filter;
  data["order"] = order;

  if(tags != "") {
    data["tags"] = $(".filters input[name='tags']").val();
  }

  var params = $.param(data);

  document.location = window.location.pathname + "?" + params;
}

function ratingStory(e){

  e.preventDefault();
  var _this = this;
  var linkText = $(_this).text();
  var count = parseInt($(_this).attr('data-count'));
  var signal = e.data.signal;

  $.ajax({
    url: $(_this).attr('href'),
    type: 'put',
    dataType: 'json',
    beforeSend: function(){

      count = count + 1;

      $(_this).text(signal + count);

      $(_this).attr('data-count', count);

    },
    error: function(){

      $(_this).text(linkText);

      $(_this).attr('data-count', --count);

    },
    success: function(res){
      var ratingHandlers = $(_this).closest(".story-ratings").children(".ratings-count");

      $.each(ratingHandlers, function( index, handler ) {

        var text = $(handler).text();

        $(handler).text(text);

      });
    }
  });

}
