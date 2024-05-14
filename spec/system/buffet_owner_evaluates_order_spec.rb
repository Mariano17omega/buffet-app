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
    Order.create!(date_event: 5.day.from_now, num_guests: '40', details:'Festa 1',
    event:event0, user_client:client0, status: :awaiting_evaluation)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCF2222')
    Order.create!(date_event: 15.day.from_now, num_guests: '40', details:'Festa 2',
    event:event1, user_client:client0, status: :awaiting_evaluation)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCF3333')
    Order.create!(date_event: 20.day.from_now, num_guests: '40',  details:'Festa 3',
    address_event:'Rua imaginaria 3',  event: event2, user_client:client0, status: :confirmed_buffet)
    #################
    client1 = UserClient.create!(email: 'cliente1@example.com', password: 'mypassword' )
    Profile.create!(name: 'Cliente1', cpf: '67309283015' , user_client: client1)

    allow(SecureRandom).to receive(:alphanumeric).and_return('MWXY2222')
    Order.create!(date_event: 15.day.from_now, num_guests: '40', details:'Festa 2',
    event:event1, user_client:client0, status: :confirmed_buffet)

    allow(SecureRandom).to receive(:alphanumeric).and_return('MWXY3333')
    Order.create!(date_event: 20.day.from_now, num_guests: '40', details:'Festa 3',
    address_event:'Rua imaginaria 3',  event: event2, user_client:client0, status: :canceled)

    # Act
    login_as(user_owner_0, scope: :user_owner)
    visit root_path
    click_on 'Pedidos'
    # Assert
    expect(page).to have_content 'Pedidos aguardando avaliação do buffet'
    expect(page).to have_content 'ABCF1111'
    expect(page).to have_content 'ABCF2222'
    expect(page).to have_content 'Pedidos confirmados e cancelados'
    expect(page).to have_content 'ABCF3333'
    expect(page).to have_content 'MWXY2222'
    expect(page).to have_content 'MWXY3333'
  end

  it 'e vê notificação de mais de um Pedido no mesmo dia na pagina de detalhes do pedido' do
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

    user_owner_3 = UserOwner.create!(email: 'd@example.com', password: 'senha123' )
    Buffet.create!( brand_name: 'Def Buffets', corporate_name: 'Corporate def' ,cnpj: '94595685000100',
                    contact_phone: '88969777936', contact_email: 'd@gmail.com',  address: 'Rua dos dois',
                    district: 'Bairro fantasia', state: 'AM', city: 'Manaus', cep: '4022-9968',
                    description: 'Buffet Otimo',   user_owner: user_owner_3 , payment_method_attributes:
                    { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                    check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' } )
    event3 = Event.create!(name:'Festa DFW' ,description:'Festa para letras DWs', min_guests:'170',
                  duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                  event_location:'false', buffet_id: user_owner_3.id , price_attributes: {price_base_weekdays: '1200',
                  price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                  price_add_weekend: '500.0', price_overtime_weekend: '400'})

    #################
    client0 = UserClient.create!(email: 'cliente0@example.com', password: 'mypassword' )
    Profile.create!(name: 'Cliente0', cpf: '71779672063' , user_client: client0)

    client1 = UserClient.create!(email: 'cliente1@example.com', password: 'mypassword' )
    Profile.create!(name: 'Cliente1', cpf: '67309283015' , user_client: client1)


    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCF1111')
    Order.create!(date_event: 5.day.from_now, num_guests: '40', details:'Festa 1',
    event:event0, user_client:client0, status: :awaiting_evaluation)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCF2222')
    Order.create!(date_event: 5.day.from_now, num_guests: '40', details:'Festa 2',
    event:event1, user_client:client0, status: :awaiting_evaluation)

    allow(SecureRandom).to receive(:alphanumeric).and_return('MWXY3333')
    Order.create!(date_event: 5.day.from_now, num_guests: '40', details:'Festa 3',
    event:event2, user_client:client1, status: :awaiting_evaluation)

    allow(SecureRandom).to receive(:alphanumeric).and_return('MWXY4444')
    Order.create!(date_event: 5.day.from_now, num_guests: '40', details:'Festa 4',
    event:event3, user_client:client1, status: :awaiting_evaluation)


    # Act
    login_as(user_owner_0, scope: :user_owner)
    visit root_path
    click_on 'Pedidos'
    click_on 'ABCF1111'
    # Assert
    expect(page).to have_content 'ABCF1111 - Aguardando avaliação do buffet'
    expect(page).to have_content "Há 2 pedidos agendados para o dia #{ 5.days.from_now.to_date.to_date.strftime("%d/%m/%Y")}:"
    expect(page).to have_content 'ABCF2222'
    expect(page).to have_content 'MWXY3333'
    expect(page).not_to have_content 'MWXY4444'
  end
end


describe 'Um Dono de Buffet visita a tela inicial' do
  context  'acessar os detalhes de um pedido a partir pagina de Pedidos' do
    it 'e vê os campos de de desconto/taxa e descrição' do
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
      client0 = UserClient.create!(email: 'cliente0@example.com', password: 'mypassword' )
      Profile.create!(name: 'Cliente0', cpf: '71779672063' , user_client: client0)

      allow(SecureRandom).to receive(:alphanumeric).and_return('ABCF1111')
      Order.create!(date_event: 5.day.from_now, num_guests: '40', details:'Festa 1',
      event:event0, user_client:client0, status: :awaiting_evaluation)

      # Act
      login_as(user_owner_0, scope: :user_owner)
      visit root_path
      click_on 'Pedidos'
      click_on 'ABCF1111'
      # Assert
      expect(page).to have_content 'ABCF1111 - Aguardando avaliação do buffet'
      expect(page).to have_content 'Taxa extra/Desconto'
      expect(page).to have_content 'Descrição da Taxa extra/Desconto'
      expect(page).to have_content 'Data de validade da Taxa extra/Desconto'
      expect(page).to have_content 'Meio de pagamento utilizado'
      expect(page).to have_button  'Aprovar pedido'

    end

    it 'e e confirma o pedido com sucesso' do
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
      client0 = UserClient.create!(email: 'cliente0@example.com', password: 'mypassword' )
      Profile.create!(name: 'Cliente0', cpf: '71779672063' , user_client: client0)

      allow(SecureRandom).to receive(:alphanumeric).and_return('ABCF1111')
      Order.create!(date_event: 5.day.from_now, num_guests: '40', details:'Festa 1',
      event:event0, user_client:client0, status: :awaiting_evaluation)

      # Act
      login_as(user_owner_0, scope: :user_owner)
      visit root_path
      click_on 'Pedidos'
      click_on 'ABCF1111'
      fill_in 'Taxa extra/Desconto',	with: '150'
      fill_in 'Descrição da Taxa extra/Desconto',	with: 'Devido as chuvas'
      fill_in  'Data de validade da Taxa extra/Desconto',	with: 3.day.from_now
      select 'Dinheiro', :from =>  'Meio de pagamento utilizado'
      #fill_in 'Meio de pagamento utilizado',	with: 'PIX'
      click_on 'Aprovar pedido'
      # Assert
      expect(page).to have_content 'Pedido confirmado com sucesso'

      expect(page).to have_content 'Taxa extra/Desconto: R$ 150'
      expect(page).to have_content 'Descrição da Taxa extra/Desconto: Devido as chuvas'
      expect(page).to have_content 'Data de validade da Taxa extra/Desconto: '+ 3.days.from_now.to_date.to_date.strftime("%d/%m/%Y")
      expect(page).to have_content 'Meio de pagamento utilizado: Dinheiro'
      expect(page).to have_content 'Valor final do pedido: R$ 5.150,00'

    end

    it 'e e confirma o pedido faltando informações' do
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
      client0 = UserClient.create!(email: 'cliente0@example.com', password: 'mypassword' )
      Profile.create!(name: 'Cliente0', cpf: '71779672063' , user_client: client0)

      allow(SecureRandom).to receive(:alphanumeric).and_return('ABCF1111')
      Order.create!(date_event: 5.day.from_now, num_guests: '40', details:'Festa 1',
      event:event0, user_client:client0, status: :awaiting_evaluation)

      # Act
      login_as(user_owner_0, scope: :user_owner)
      visit root_path
      click_on 'Pedidos'
      click_on 'ABCF1111'
      fill_in 'Taxa extra/Desconto',	with: ''
      fill_in 'Descrição da Taxa extra/Desconto',	with: ''
      fill_in  'Data de validade da Taxa extra/Desconto',	with: ''
      select 'Dinheiro', :from =>  'Meio de pagamento utilizado'
      #fill_in 'Meio de pagamento utilizado',	with: 'PIX'
      click_on 'Aprovar pedido'
      # Assert
      expect(page).to have_content 'O pedido não foi confirmado'

    end
  end
end
