class ProfilesController < ApplicationController

  def new
    @profile = current_user_client.build_profile
  end

  def create
    @profile = current_user_client.build_profile(profile_params)
    if @profile.save
      redirect_to root_path, notice: 'Perfil criado com sucesso!'
    else
      render :new
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :cpf)
  end

end
