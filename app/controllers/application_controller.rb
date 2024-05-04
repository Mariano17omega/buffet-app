class ApplicationController < ActionController::Base

  private
  def after_sign_in_path_for(resource_or_scope)
    if current_user_owner.present?
      current_user_owner.buffet.nil? ? new_buffet_path : buffet_path(current_user_owner.buffet)
    elsif current_user_client.present?
      current_user_client.profile.nil? ? new_profile_path : root_path
    end
  end


end
