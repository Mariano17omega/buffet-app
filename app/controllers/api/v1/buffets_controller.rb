class Api::V1::BuffetsController < Api::V1::ApiController
  def show
    buffet = Buffet.find(params[:id])
    render status: 200, json: buffet.as_json(except: [:corporate_name, :cnpj, :created_at, :updated_at],
                                            include: { payment_method: {except: [:created_at, :updated_at, :buffet_id, :id]}})
  end

  def index
    buffets = Buffet.all.order(:brand_name)
    buffet_json = buffets.map do |buffet|
      buffet.as_json(except: [:corporate_name, :cnpj, :created_at, :updated_at],
                    include: { payment_method: {except: [:created_at, :updated_at, :buffet_id, :id]}})
    end
    render status: 200, json: buffet_json
  end

  def search
    query = params['query']
    buffets =  Buffet.all.where("buffets.brand_name LIKE? ", "%#{query}%" ).order(:brand_name)
    buffet_json = buffets.map do |buffet|
      buffet.as_json(except: [:corporate_name, :cnpj, :created_at, :updated_at],
                    include: { payment_method: {except: [:created_at, :updated_at, :buffet_id, :id]}})
    end
    render status: 200, json: buffet_json
  end
end
