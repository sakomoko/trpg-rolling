<% if @applicant.errors.any? %>
  $("#applicant-error").append('<%= j(render "error") %>')
  $("#applicant-error").find(".alert").alert()
<% else %>
  $("#applicants-container").append('<%= j(render(@applicant)) %>')
  $("#entry-modal").modal("hide")
<% end %>