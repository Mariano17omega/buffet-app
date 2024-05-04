Faker::Config.locale = 'pt-BR'
#Faker::Config.default_locale = 'pt-BR'

types_of_events = [
  "Aniversario",
  "Casamento",
  "Formatura",
  "Reuniao_de_negocios",
  "Conferencia",
  "Workshop",
  "Seminario",
  "Exposicao",
  "Feira",
  "Recepcao",
  "Coquetel",
  "Evento Corporativo",
  "Eetiro Empresarial",
  "Convencao",
  "Simposio",
  "Congresso",
  "Reuniao Social",
  "Festa de Formatura",
  "Festa de Casamento",
  "Festa de Aniversario"
]

# Seed para criar os donos de buffets
10.times do
  email= Faker::Internet.unique.email
  user_owner = UserOwner.create!(email: email, password: 'senha123')

  brand_name = Faker::Restaurant.unique.name
  corporate_name = brand_name + " LTDA"

  buffet_user_owner = Buffet.create!(
    brand_name: brand_name,
    corporate_name: corporate_name,
    cnpj: Faker::Company.unique.brazilian_company_number(formatted: true),
    contact_phone: Faker::PhoneNumber.unique.cell_phone,
    contact_email: email,
    address: Faker::Address.street_address,
    district: Faker::Address.community,
    state: Faker::Address.state,
    city: Faker::Address.city,
    cep: Faker::Address.zip_code,
    description: Faker::Restaurant.unique.description,
    playment_methods: 'PIX',
    user_owner: user_owner
  )

  # Seed para criar eventos de cada buffet
  5.times do

    price_attributes = {
      price_base_weekdays: Faker::Commerce.price(range: 1000..7000),
      price_add_weekdays: Faker::Commerce.price(range: 100..150),
      price_overtime_weekdays: Faker::Commerce.price(range: 500..800),
      price_base_weekend: Faker::Commerce.price(range: 1500..10000),
      price_add_weekend: Faker::Commerce.price(range: 200..400),
      price_overtime_weekend: Faker::Commerce.price(range: 800..1500)
    }

    Event.create!(
      name: types_of_events.sample + ' - ' +Faker::Coffee.blend_name + ' ' + Faker::Restaurant.type,
      description: Faker::Lorem.unique.paragraph,
      min_guests: Faker::Number.between(from: 10, to: 50),
      max_guests: Faker::Number.between(from: 60, to: 200),
      duration: Faker::Number.between(from: 60, to: 720),
      menu: Array.new(10) { Faker::Food.dish }.join(', '),
      decoration: [true, false].sample,
      alcoholic_beverages: [true, false].sample,
      parking_servise: [true, false].sample,
      event_location: [true, false].sample,
      buffet: buffet_user_owner,
      price_attributes: price_attributes
    )
  end
end
