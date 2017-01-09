module ApplicationHelper
  
  def has_admin_right?
    has_user_right? && current_user.admin_role # todo add cancancan later
  end

  def has_user_right?
    user_signed_in?
  end
  
  def is_owner?(user)
    has_user_right? && current_user == user
  end

  def ts(value, format=:std)
    return unless value
    case format
      when :date
        value.to_time.strftime("%d.%m.%Y")
      else
        value.to_time.strftime("%d.%m.%Y %H:%M")
    end
  end
  
end
