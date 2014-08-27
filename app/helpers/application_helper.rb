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
end
