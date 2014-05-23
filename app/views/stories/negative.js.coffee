$ ->
  $(".story-ratings a[data-remote=true]").on "ajax:success", (e, data, status, xhr) ->
    $("div#story-votes-<%=@story.id%>").html("<%= escape_javascript(render partial: 'home/ratings', locals: {story: @story}) %>")
