module ApplicationHelper
  
  def has_admin_right?
    has_user_right? # todo add cancancan later
    # #true  # todo, comment, dev only! remove
  end

  def has_user_right?
    user_signed_in?
    #true  # todo, comment, dev only! remove
  end
  
  def is_owner?(user)
    #Rails.logger.debug("is_owner? user == current_user * #{current_user == user} *: #{user.name} == #{current_user.name}")
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
