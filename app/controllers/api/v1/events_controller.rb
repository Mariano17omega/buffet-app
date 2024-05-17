class Api::V1::EventsController < Api::V1::ApiController
  before_action :availability_params_valid?, only: [:availability]

  def index
    events = Buffet.find(params[:buffet_id]).events.order(:name)
    events_json = events.map do |event|
      event.as_json(except: [:created_at, :updated_at, :buffet_id],
                     include: { price: {except: [:created_at, :updated_at, :event_id, :id]}})
    end
    render status: 200, json: events_json
  end

  def availability
    event = Event.find(params[:event_id])
    date_event =  Date.parse(params[:date_event])
    num_guests = params[:num_guests].to_i

    if event.min_guests >= num_guests
      base_cost = date_event.saturday? || date_event.sunday? ? event.price.price_base_weekend : event.price.price_base_weekdays
    else
      base_cost = date_event.saturday? || date_event.sunday? ? event.price.price_base_weekend + event.price.price_add_weekend * ( num_guests - event.min_guests ) : event.price.price_base_weekdays + event.price.price_add_weekdays * ( num_guests - event.min_guests )
    end

    return render status: 200, json: base_cost.as_json
  end

  private

  def availability_params_valid?
    if !params.key?(:event_id) ||  Event.find(params[:event_id]).nil?
      return render status: 404, json: { errors: { event: 'Evento não encontrado' } }
    elsif !params.key?(:date_event) ||  !( (params[:date_event]).to_date > Date.today  )
      return render status: 422, json: { errors: { date_event: 'A data do evento deve ser no futuro' } }

    elsif !params.key?(:num_guests) ||  !(params[:num_guests].to_i > 0)
      return render status: 422, json: { errors: { num_guests: 'O número de convidados deve ser maior que zero' } }
    end
  end

end
