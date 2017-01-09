module ApplicationHelper
  
  def has_admin_right?
    #has_user_right? && current_user.admin_role # deprecated thru can
    can? :manage, :all
  end

  def has_user_right?
    #user_signed_in? # deprecated thru can
    can? :manage, :own
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
  
  def master_admin?(user)
    user.name == 'admin'
  end
  
end
