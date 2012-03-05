module ApplicationHelper
  include BootstrapFormBuilder::FormHelper

  def markdown(text)
    @renderer ||= Redcarpet::Render::HTML.new(:hard_wrap => true)
    Redcarpet::Markdown.new(@renderer, :autolink => true, :fenced_code_blocks => true).render(text).html_safe
  end

  def back_from_room(parent)
    if parent.class == World
      link_to 'Back', parent, :class => 'btn'
    elsif parent.class == Session
      link_to 'Back', [parent.world, parent], :class => 'btn'
    else
      raise "invalid parent model class"
    end
  end
end
