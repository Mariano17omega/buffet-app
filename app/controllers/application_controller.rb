class ApplicationController < ActionController::Base

  private
  def after_sign_in_path_for(resource_or_scope)
    if current_user_owner.buffet.nil?
      new_buffet_path
    else
      buffet_path(current_user_owner.buffet)
    end
  end

end
