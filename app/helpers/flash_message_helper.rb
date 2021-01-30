# frozen_string_literal: true
module FlashMessageHelper
  def flash_class(level)
    case level
    when 'notice'  then "alert alert-info"
    when 'success' then "alert alert-success"
    when 'error'   then "alert alert-danger"
    when 'alert'   then "alert alert-warning"
    end
  end

  def flash_message(id = "flash_messages", _data_target = "")
    content_tag :div,
      id: id do
      render 'layouts/shared/flash_messages'
    end
  end

  def flash_message_row
    content_tag :div, class: "row" do
      content_tag :div, class: "col-md-12" do
        flash_message
      end
    end
  end
end
