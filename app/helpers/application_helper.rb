module ApplicationHelper

  def foundation_class_for flash_type
    case flash_type
      when :success
        "alert-box round success"
      when :error
        "alert-box round alert"
      when :alert
        "alert-box round warning"
      when :notice
        "alert-info round info"
      else
        flash_type.to_s
    end
  end

  def markdown(content)
    options = [autolink: true, hard_wrap: true, filter_html: true, safe_links_only: true]
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, *options )
    
    content_tag(:blockquote, id: 'text_content') do
      @markdown.render(content).html_safe
    end
  end

  
end
