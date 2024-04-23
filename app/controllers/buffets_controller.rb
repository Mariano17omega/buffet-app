class BuffetsController < ApplicationController
  before_action :authenticate_user_owner!, only: [:new, :edit, :update, :create]
  before_action :set_buffet, only: [:show, :edit, :update]

  def index
    @buffets = Buffet.all
  end

  def show
  end

  def new
    @buffet = Buffet.new()
  end

  def edit; end

  def update
    if @buffet.update(buffet_params)
      redirect_to buffet_path(  @buffet.id ), notice: 'Buffet editado com sucesso.'
    else
      flash[:notice] = 'Não foi possível editar o Buffet.'
      render 'edit'
    end
  end

  def create
    @buffet = Buffet.new(buffet_params)
    @buffet.user_owner = current_user_owner
    if @buffet.save
      redirect_to buffets_path, notice: 'Buffet cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Buffet não cadastrado.'
      render 'new'
    end
  end

  private

  def set_buffet
    @buffet =  Buffet.find(params[:id])
  end

  def buffet_params
    params.require(:buffet).permit( :corporate_name, :brand_name, :cnpj, :contact_phone,
                                    :contact_email, :address, :district, :state, :city, :cep,
                                    :description, :playment_methods)
  end
end
