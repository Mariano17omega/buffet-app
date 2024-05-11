class OrdersController < ApplicationController
  before_action :set_buffet_event, only: [:new, :show, :create]
  before_action :set_order, only: [:show]

  def new
    @order=Order.new
  end

  def show
    if @event.min_guests >= @order.num_guests

      if @order.date_event.saturday? || @order.date_event.sunday?
        @total_cost = @event.price.price_base_weekend
        @cost_overtime = @event.price.price_overtime_weekend
      else
        @total_cost = @event.price.price_base_weekdays
        @cost_overtime = @event.price.price_overtime_weekdays
      end
    else
      if @order.date_event.saturday? || @order.date_event.sunday?
        @total_cost = @event.price.price_base_weekend + @event.price.price_add_weekend * @order.num_guests
        @cost_overtime = @event.price.price_overtime_weekend
      else
        @total_cost = @event.price.price_base_weekdays + @event.price.price_add_weekdays * @order.num_guests
        @cost_overtime = @event.price.price_overtime_weekdays
      end
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

  def my_orders
    @orders=current_user_client.orders
  end

  def orders_buffet
    @orders_awaiting_evaluation = Order.event#.awaiting_evaluation
  end

  private
  def set_buffet_event
    @buffet = Buffet.find(params[:buffet_id])
    @event =  Event.find(params[:event_id])
  end
  def order_params
    params.require(:order).permit( :date_event, :num_guests, :details, :address_event)
  end

  def set_order
    @order =  Order.find(params[:id])
  end
end
