<% if @applicant.errors.any? %>
  $("#applicant_error").append('<%= j(render "error") %>')
  $("#applicant_error").find(".alert").alert()
<% else %>
  $("#applicants").append('<%= j(render(@applicant)) %>')
  $("#entry-modal").modal("hide")
<% end %>