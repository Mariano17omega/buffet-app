class OrdersController < ApplicationController
  before_action :authenticate_users, only: [:show, :update]
  before_action :authenticate_user_client!, only: [:new,:create, :my_orders]
  before_action :authenticate_user_owner!, only: [:orders_buffet]

  before_action :set_order, only: [:show, :update]
  before_action :set_event, only: [:new,  :create]

  def new
    @order=Order.new
  end

  def show
    if current_user_owner.present?
      @repeat_orders = current_user_owner.orders.where(date_event: @order.date_event).where.not(id: @order.id)
    end

  end

  def create
    @order=Order.new(order_params)
    @order.event = @event
    @order.user_client = current_user_client

    if @order.save
      redirect_to my_orders_path, notice:  'Pedido feito com sucesso.'
    else
      flash.now[:notice] = 'Pedido não realizado.'
      render 'new'
    end
  end

  def update
    if @order.update(order_params)
      redirect_to order_path( @order ), notice: 'Pedido confirmado com sucesso'
    else
      flash[:notice] = 'O pedido não foi confirmado'
      render 'show'
    end
  end

  #Desativa a validação "presence: true, on: :update" para atualizar apenas o Status
  def canceled_status
    @order = Order.find(params[:id])
    if @order.update_attribute!(:status, params[:status])
      redirect_to order_path(@order), notice: 'Pedido cancelado com sucesso.'
    else
      flash[:alert] = 'Erro ao Cancelado o pedido.'
      render :show
    end
  end

  def my_orders
    @orders=current_user_client.orders
  end

  def orders_buffet
    @orders_awaiting_evaluation = current_user_owner.orders.awaiting_evaluation
    @orders_confirmed_canceled =  current_user_owner.orders.where( status: [:confirmed_buffet, :confirmed_client, :canceled] )

  end

  private

  def order_params
    if user_owner_signed_in?
      params.require(:order).permit(:status, :extra_fee_discount,:extra_fee_discount_description, :payment_method_used, :expiration_date)
    elsif  user_client_signed_in?
      params.require(:order).permit(:status, :date_event, :num_guests, :details, :address_event)
    end
  end

  def set_order
    @order =  Order.find(params[:id])
  end

  def set_event
    @event =  Event.find(params[:event_id])
  end

  def authenticate_users
    unless current_user_owner.present? || current_user_client.present?
      redirect_to root_path, notice: 'Você não tem autorização para acessar esta página.'
    end
  end
end
