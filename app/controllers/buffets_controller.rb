class BuffetsController < ApplicationController
  before_action :authenticate_user_owner!, only: [:new,:edit,:create, :update]
  before_action :set_buffet, only: [:show, :edit, :update]


  def show
    @events=@buffet.events
  end

  def new
    @buffet = Buffet.new()
  end

  def edit
    unless current_user_owner == @buffet.user_owner
      redirect_to buffet_path(@buffet), alert: 'Você não tem permissão para editar este buffet.'
    end
  end

  def update
    if current_user_owner == @buffet.user_owner
      if @buffet.update(buffet_params)
        redirect_to buffet_path(@buffet), notice: 'Buffet editado com sucesso.'
      else
        flash.now[:notice] = 'Não foi possível editar o Buffet.'
        render 'edit'
      end
    else
      redirect_to buffet_path(@buffet), alert: 'Você não tem permissão para editar este buffet.'
    end
  end

  def create
    @buffet = Buffet.new(buffet_params)
    @buffet.user_owner = current_user_owner

    if @buffet.save
      redirect_to buffet_path(  @buffet.id ), notice:  'Buffet cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Buffet não cadastrado.'
      render 'new'
    end
  end

  def search
    @query = params["query"]
    @buffets = Buffet.joins(:events).where("buffets.brand_name LIKE? OR events.name LIKE? OR buffets.city LIKE?", "%#{@query}%", "%#{@query}%", "%#{@query}%" ).order("buffets.brand_name").distinct

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
