$(function(){

  $("span.positive-votes a").on("click", { signal: '+' }, ratingStory);

  $("span.negative-votes a").on("click", { signal: '-' }, ratingStory);

});

function ratingStory(e){

  e.preventDefault();
  var _this = this;
  var linkText = $(_this).text();
  var count = parseInt($(_this).attr('data-count'));
  var signal = e.data.signal;

  if($(_this).attr('href') === "#") return ;

  $.ajax({
    url: $(_this).attr('href'),
    type: 'put',
    dataType: 'json',
    beforeSend: function(){

      count = count + 1;

      $(_this).text(signal + count);

      $(_this).attr('data-count', count);

      $(_this).attr('href', "#");

    },
    error: function(){

      $(_this).text(linkText);

      $(_this).attr('data-count', --count);

    },
    success: function(res){
      
    }
  });
  

}