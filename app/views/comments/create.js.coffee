<% if @comment.errors.any? %>
  $("#comment_error").append('<%= j(render "error") %>')
  $("#comment_error").find(".alert").alert()
<% else %>
  $("#comments-container").prepend('<%= j(render(@comment)) %>')
  $("#comment_body").val("")
<% end %>