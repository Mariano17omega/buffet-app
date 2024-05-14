class OrdersController < ApplicationController
  before_action :set_buffet_event, only: [:new, :show, :create, :update]
  before_action :set_order, only: [:show, :update]

  def new
    @order=Order.new
  end

  def show
    price_order
    @repeat_orders = Order.joins(:event).where(events: { id: @buffet.events.select(:id) }).where(date_event: @order.date_event).where.not(id: @order.id)

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
        if @order.awaiting_evaluation? && @order.extra_fee_discount.present?
          @order.update(status: :confirmed_buffet)
        end

        redirect_to orders_buffet_path, notice: 'Pedido confirmado com sucesso'
      else
        flash[:notice] = 'O pedido não foi confirmado'
        render 'show'
      end
  end


  def my_orders
    @orders=current_user_client.orders
  end

  def orders_buffet
    @buffet=current_user_owner.buffet
    @orders_awaiting_evaluation = Order.joins(:event).where(events: { id: @buffet.events.select(:id) }).awaiting_evaluation
    @orders_confirmed_canceled = Order.joins(:event).where(events: { id: @buffet.events.select(:id) }, status: [:confirmed_buffet, :confirmed_client, :canceled])
  end

  private
  def set_buffet_event
    @buffet = Buffet.find(params[:buffet_id])
    @event =  Event.find(params[:event_id])
  end
  def order_params
    user_owner_signed_in?  ? params.require(:order).permit(:extra_fee_discount,:extra_fee_discount_description, :payment_method_used, :expiration_date): params.require(:order).permit( :date_event, :num_guests, :details, :address_event)
  end

  def set_order
    @order =  Order.find(params[:id])
  end

  def price_order
    if @event.min_guests >= @order.num_guests
      @base_cost = @order.date_event.saturday? || @order.date_event.sunday? ? @event.price.price_base_weekend : @event.price.price_base_weekdays
      @overtime_cost = @order.date_event.saturday? || @order.date_event.sunday? ? @event.price.price_overtime_weekend : @event.price.price_overtime_weekdays
    else
      @base_cost = @order.date_event.saturday? || @order.date_event.sunday? ? @event.price.price_base_weekend + @event.price.price_add_weekend * @order.num_guests : @event.price.price_base_weekdays + @event.price.price_add_weekdays * @order.num_guests
      @overtime_cost = @order.date_event.saturday? || @order.date_event.sunday? ? @event.price.price_overtime_weekend : @event.price.price_overtime_weekdays
    end

  end
end
