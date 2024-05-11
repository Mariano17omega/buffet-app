require 'rails_helper'

describe 'Um Dono de Buffet visita a tela inicial' do
  it 'e vê o botão de Pedidos' do
    # Arrange
    user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
    # Act
    login_as(user_owner_0, scope: :user_owner)
    visit root_path
    # Assert
    expect(page).to have_content 'Pedidos'
  end

  it 'e acessar a pagina de Pedidos' do
    # Arrange
    user_owner_0 = UserOwner.create!(email: 'a110@example.com', password: 'senha123' )
    Buffet.create!( brand_name: 'C.C. Buffets', corporate_name: 'Buffet Zero' ,cnpj: '88802612000149',
                    contact_phone: '88969721936', contact_email: 'buffetcc@gmail.com',  address: 'Rua dos dois',
                    district: 'Bairro fantasia', state: 'SP', city: 'São Paulo', cep: '4522-9968',
                    description: 'Buffet para festas',  user_owner: user_owner_0 , payment_method_attributes:
                    { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                    check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' } )
    event0 = Event.create!(name:'Festa AB' ,description:'Festa para letras', min_guests:'160',
                  duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                  event_location:'true', buffet_id: user_owner_0.id, price_attributes: {price_base_weekdays: '1200',
                  price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                  price_add_weekend: '500.0', price_overtime_weekend: '400'})

    event1 = Event.create!(name:'Festa CDEFS' ,description:'Festa para letras diferentes ', min_guests:'140',
                  duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                  event_location:'true', buffet_id: user_owner_0.id , price_attributes: {price_base_weekdays: '1200',
                  price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                  price_add_weekend: '500.0', price_overtime_weekend: '400'})

    event2 = Event.create!(name:'Festa DEF' ,description:'Festa para letras D', min_guests:'180',
                  duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                  event_location:'false', buffet_id: user_owner_0.id , price_attributes: {price_base_weekdays: '1200',
                  price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                  price_add_weekend: '500.0', price_overtime_weekend: '400'})
    #################
    client0 = UserClient.create!(email: 'cliente0@example.com', password: 'mypassword' )
    Profile.create!(name: 'Cliente0', cpf: '71779672063' , user_client: client0)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCF1111')
    Order.create!(date_event: 5.day.from_now, num_guests: '40', code:'ABCF1111', details:'Festa 1',
    event:event0, user_client:client0)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCF2222')
    Order.create!(date_event: 15.day.from_now, num_guests: '40', code:'ABCF2222', details:'Festa 2',
    event:event1, user_client:client0)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCF3333')
    Order.create!(date_event: 20.day.from_now, num_guests: '40', code:'ABCF3333', details:'Festa 3',
    address_event:'Rua imaginaria 3',  event: event2, user_client:client0)
    #################
    client1 = UserClient.create!(email: 'cliente1@example.com', password: 'mypassword' )
    Profile.create!(name: 'Cliente1', cpf: '67309283015' , user_client: client1)

    allow(SecureRandom).to receive(:alphanumeric).and_return('MWXY2222')
    Order.create!(date_event: 15.day.from_now, num_guests: '40', code:'MWXY2222', details:'Festa 2',
    event:event1, user_client:client0)

    allow(SecureRandom).to receive(:alphanumeric).and_return('MWXY3333')
    Order.create!(date_event: 20.day.from_now, num_guests: '40', code:'MWXY3333', details:'Festa 3',
    address_event:'Rua imaginaria 3',  event: event2, user_client:client0)

    # Act
    login_as(user_owner_0, scope: :user_owner)
    visit root_path
    click_on 'Pedidos'
    # Assert
    expect(page).to have_content 'Aguardando avaliação'
    expect(page).to have_content 'Cancelados'
    expect(page).to have_content 'confirmados'
  end
end
