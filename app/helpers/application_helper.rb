module ApplicationHelper
  include BootstrapFormBuilder::FormHelper

  def markdown(text)
    @renderer ||= Redcarpet::Render::HTML.new(:hard_wrap => true)
    Redcarpet::Markdown.new(@renderer, :autolink => true, :fenced_code_blocks => true).render(text).html_safe
  end
end
