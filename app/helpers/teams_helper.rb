# frozen_string_literal: true
module TeamsHelper
  def format_short_name(name)
    name[0, 3] if name
  end
end
