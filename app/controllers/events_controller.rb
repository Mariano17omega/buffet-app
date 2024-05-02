class EventsController < ApplicationController
  before_action :authenticate_user_owner!, only: [:new, :create, :edit, :update]
  before_action :set_buffet, only: [:new, :show, :create, :edit, :update]
  before_action :set_event, only: [:show,  :edit, :update]

  def show
  end

  def new
    @event = Event.new
    @event.build_price
  end

  def edit
    @event.build_price unless @event.price
    unless current_user_owner == @buffet.user_owner
      redirect_to buffet_event_path(@buffet, @event), alert: 'Você não tem permissão para editar este evento.'
    end
  end

  def update
    if current_user_owner == @buffet.user_owner
      if @event.update(event_params)
        redirect_to buffet_event_path(@buffet, @event), notice: 'Evento editado com sucesso.'
      else
        flash.now[:notice] = 'Não foi possível editar o Evento.'
        render 'edit'
      end
    else
      redirect_to buffet_event_path(@buffet, @event), alert: 'Você não tem permissão para editar este Evento.'
    end
  end

  def create
    @event = Event.new(event_params)
    @event.buffet_id = @buffet.id

    if @event.save
      redirect_to buffet_event_path(@buffet, @event), notice:  'Evento cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Evento não cadastrado.'
      render 'new'
    end
  end


  private

  def set_event
    @event =  Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit( :name,:description, :min_guests, :max_guests, :duration,
                                   :menu, :alcoholic_beverages, :decoration, :parking_servise, :event_location ,
                                   price_attributes:[ :id, :price_base_weekdays, :price_add_weekdays, :price_overtime_weekdays,
                                   :price_base_weekend, :price_add_weekend, :price_overtime_weekend ])
  end



  def set_buffet
    @buffet = Buffet.find(params[:buffet_id])
  end
end
