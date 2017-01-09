module ApplicationHelper
  
  def has_admin_right?
    has_user_right? # todo add cancancan later && x
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
end
