require 'rails_helper'

describe 'Um cliente visita tela inicial' do
  context 'acessar um evento de um Buffet' do
    it 'e vê o botão para fazer um pedido' do
      # Arrange
      client = UserClient.create!(email: 'clientex@example.com', password: 'mypassword' )
      Profile.create!(name: 'ClienteX', cpf: '19626041013' , user_client: client)


      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      buffet_0 =Buffet.create!( brand_name: 'Buffet FFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '97990518000151',
                                contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                                district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                                description: 'Buffet para festas fantasticas', user_owner: user_owner_0, payment_method_attributes:
                                { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'false',
                                check: 'false', pix: 'true', bitcoin: 'false', google_pay: 'false' }  )
      Event.create!(name:'Festa da B2' ,description:'Festa de androids', min_guests:'110',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_0.id, price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      # Act
      login_as(client, scope: :user_client)
      visit root_path
      click_on 'Buffet Fantasticos'
      click_on 'Festa da B2'

      # Assert
      expect(page).to have_content 'Fazer pedido'
    end

    it 'e vê um formulario para fazer o pedido' do
      # Arrange


      client = UserClient.create!(email: 'clientex@example.com', password: 'mypassword' )
      Profile.create!(name: 'ClienteX', cpf: '19626041013' , user_client: client)

      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      buffet_0 =Buffet.create!( brand_name: 'Fantasticos BFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '97990518000151',
                                contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                                district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                                description: 'Buffet para festas fantasticas', user_owner: user_owner_0, payment_method_attributes:
                                { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'false',
                                check: 'false', pix: 'true', bitcoin: 'false', google_pay: 'false' }  )
      Event.create!(name:'Festa da B2' ,description:'Festa de androids', min_guests:'110',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_0.id, price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      # Act
      login_as(client, scope: :user_client)
      visit root_path
      click_on 'Buffet Fantasticos'
      click_on 'Festa da B2'
      click_on 'Fazer pedido'

      # Assert
      expect(page).to have_content 'Novo Pedido para Festa da B2'
      expect(page).to have_content 'Buffet Fantasticos BFs'
      expect(page).to have_field 'Data do evento'
      expect(page).to have_field 'Quantidade de convidados'
      expect(page).to have_field 'Detalhes sobre o evento'
      expect(page).to have_content 'Informe o endereço do evento se ele for em um local diferente do endereço do Bufeet'
      expect(page).to have_field  'Local do evento'
    end

    it 'e faz um pedido com sucesso' do
      # Arrange

      client = UserClient.create!(email: 'clientex@example.com', password: 'mypassword' )
      Profile.create!(name: 'ClienteX', cpf: '19626041013' , user_client: client)

      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      buffet_0 =Buffet.create!( brand_name: 'Fantasticos BFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '97990518000151',
                                contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                                district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                                description: 'Buffet para festas fantasticas', user_owner: user_owner_0, payment_method_attributes:
                                { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'false',
                                check: 'false', pix: 'true', bitcoin: 'false', google_pay: 'false' }  )
      Event.create!(name:'Festa da B2' ,description:'Festa de androids', min_guests:'110',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_0.id, price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      # Act
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABCF1234')
      login_as(client, scope: :user_client)
      visit root_path
      click_on 'Buffet Fantasticos'
      click_on 'Festa da B2'
      click_on 'Fazer pedido'

      fill_in 'Data do evento', with: 5.day.from_now.to_date
      fill_in 'Quantidade de convidados', with: '40'
      fill_in 'Detalhes sobre o evento', with: 'Festa apenas para androids'
      fill_in 'Local do evento', with: 'Rua imaginaria, n. i'
      click_on 'Enviar pedido'
      # Assert
      expect(page).to have_content 'Meus Pedidos'
      expect(page).to have_content 'ABCF1234'
      expect(page).to have_content 'Festa da B2'
      expect(page).to have_content 5.days.from_now.to_date.to_date.strftime("%d/%m/%Y")
      expect(page).to have_content 'Aguardando avaliação do buffet'
    end

    it 'e faz um pedido com a data no passado' do
      # Arrange

      client = UserClient.create!(email: 'clientex@example.com', password: 'mypassword' )
      Profile.create!(name: 'ClienteX', cpf: '19626041013' , user_client: client)

      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      buffet_0 =Buffet.create!( brand_name: 'Fantasticos BFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '97990518000151',
                                contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                                district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                                description: 'Buffet para festas fantasticas', user_owner: user_owner_0, payment_method_attributes:
                                { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'false',
                                check: 'false', pix: 'true', bitcoin: 'false', google_pay: 'false' }  )
      Event.create!(name:'Festa da B2' ,description:'Festa de androids', min_guests:'110',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_0.id, price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      # Act
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABCF1234')
      login_as(client, scope: :user_client)
      visit root_path
      click_on 'Buffet Fantasticos'
      click_on 'Festa da B2'
      click_on 'Fazer pedido'

      fill_in 'Data do evento', with: Date.today - 30
      fill_in 'Quantidade de convidados', with: '40'
      fill_in 'Detalhes sobre o evento', with: 'Festa apenas para androids'
      fill_in 'Local do evento', with: 'Rua imaginaria, n. i'
      click_on 'Enviar pedido'
      # Assert
      expect(page).to have_content 'Novo Pedido para Festa da B2'
      expect(page).to have_content 'Pedido não realizado.'
      expect(page).to have_content 'Data do evento deve ser futura.'
    end
  end

  context 'acessar seus eventos' do
    it 'e vê a lista de todos os seus pedidos' do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'a110@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'C.C. Buffets', corporate_name: 'Buffet Zero' ,cnpj: '88802612000149',
                      contact_phone: '88969721936', contact_email: 'buffetcc@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'SP', city: 'São Paulo', cep: '4522-9968',
                      description: 'Buffet para festas',  user_owner: user_owner_0 , payment_method_attributes:
                      { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                      check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' } )
      event0 = Event.create!(name:'Festa AB' ,description:'Festa para letras', min_guests:'110',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: user_owner_0.id, price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})

      user_owner_2 = UserOwner.create!(email: 'c@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Bcd Buffets', corporate_name: 'Corporate bca' ,cnpj: '80834870000103',
                      contact_phone: '88969921936', contact_email: 'c@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'PA', city: 'Santarem', cep: '4522-9900',
                      description: 'Festas festas',   user_owner: user_owner_2 , payment_method_attributes:
                      { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                      check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' })
      event1 = Event.create!(name:'Festa CDEFS' ,description:'Festa para letras diferentes ', min_guests:'110',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: user_owner_0.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})

      user_owner_3 = UserOwner.create!(email: 'd@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Def Buffets', corporate_name: 'Corporate def' ,cnpj: '94595685000100',
                      contact_phone: '88969777936', contact_email: 'd@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'AM', city: 'Manaus', cep: '4022-9968',
                      description: 'Buffet Otimo',   user_owner: user_owner_3 , payment_method_attributes:
                      { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                      check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' } )
      event2 = Event.create!(name:'Festa DEF' ,description:'Festa para letras D', min_guests:'110',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: user_owner_3.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})

      client0 = UserClient.create!(email: 'cliente0@example.com', password: 'mypassword' )
      Profile.create!(name: 'Cliente0', cpf: '71779672063' , user_client: client0)
      # Act
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABCF1111')
      Order.create!(date_event: 5.day.from_now, num_guests: '40',  details:'Festa 1',
      event:event0, user_client:client0)

      allow(SecureRandom).to receive(:alphanumeric).and_return('ABCF2222')
      Order.create!(date_event: 15.day.from_now, num_guests: '40', details:'Festa 2',
      event:event1, user_client:client0)

      allow(SecureRandom).to receive(:alphanumeric).and_return('ABCF3333')
      Order.create!(date_event: 20.day.from_now, num_guests: '40', details:'Festa 3',
      address_event:'Rua imaginaria 3',  event: event2, user_client:client0)

      login_as(client0, scope: :user_client)
      visit root_path
      click_on  'Meus Pedidos'

      # Assert
      expect(page).to have_content 'Meus Pedidos'
      expect(page).to have_content 'ABCF1111'
      expect(page).to have_content 5.days.from_now.to_date.to_date.strftime("%d/%m/%Y")
      expect(page).to have_content 'ABCF2222'
      expect(page).to have_content 15.days.from_now.to_date.to_date.strftime("%d/%m/%Y")
      expect(page).to have_content 'ABCF3333'
      expect(page).to have_content 20.days.from_now.to_date.to_date.strftime("%d/%m/%Y")
    end

    it 'e vê os detalhes de um pedido' do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'a@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'C.C. Buffets', corporate_name: 'Buffet Zero' ,cnpj: '88802612000149',
                      contact_phone: '88969721936', contact_email: 'buffetcc@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'SP', city: 'São Paulo', cep: '4522-9968',
                      description: 'Buffet para festas',  user_owner: user_owner_0 , payment_method_attributes:
                      { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                      check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' } )
      event0 = Event.create!(name:'Festa AB' ,description:'Festa para letras', min_guests:'110',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: user_owner_0.id, price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})


      client0 = UserClient.create!(email: 'cliente0@example.com', password: 'mypassword' )
      Profile.create!(name: 'Cliente0', cpf: '71779672063' , user_client: client0)
      # Act
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABCF1111')
      Order.create!(date_event: 5.day.from_now, num_guests: '40',  details:'Festa 1',
      event:event0, user_client:client0)

      login_as(client0, scope: :user_client)
      visit root_path
      click_on 'Meus Pedidos'
      click_on 'ABCF1111'

      # Assert
      expect(page).to have_content 'ABCF1111'
      expect(page).to have_content 'Festa AB'
      expect(page).to have_content "Data do evento: #{5.days.from_now.to_date.to_date.strftime("%d/%m/%Y")}"
      expect(page).to have_content 'Detalhes: Festa 1'
      expect(page).to have_content 'Número de convidados: 40'
    end
  end
end
