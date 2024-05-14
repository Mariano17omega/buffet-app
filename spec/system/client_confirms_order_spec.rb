require 'rails_helper'

describe 'Um cliente visita tela inicial' do
  context 'acessar Seus Pedidos' do
    it 'e vê os detalhes de um pedido que aguardar sua Confirmação' do
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
      event:event0, user_client:client0, extra_fee_discount: '200', extra_fee_discount_description: 'Clima Ruim',
      payment_method_used: 'PIX', expiration_date: 4.day.from_now , status: :confirmed_buffet)



      login_as(client0, scope: :user_client)
      visit root_path
      click_on 'Meus Pedidos'
      click_on 'ABCF1111'

      # Assert
      expect(page).to have_content 'Pedido aprovado pelo buffet'
      #expect(page).to have_button  'Cancelar pedido'
      expect(page).to have_button  'Confirmar pedido'

      expect(page).to have_content 'ABCF1111'
      expect(page).to have_content 'Festa AB'
      expect(page).to have_content "Data do evento: #{5.days.from_now.to_date.to_date.strftime("%d/%m/%Y")}"
      expect(page).to have_content 'Detalhes: Festa 1'
      expect(page).to have_content 'Número de convidados: 40'
      expect(page).to have_content '200'
      expect(page).to have_content 'Clima Ruim'
      expect(page).to have_content 'PIX'
    end

    it 'e Confirma seu pedido com sucesso' do
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
      event:event0, user_client:client0, extra_fee_discount: '200', extra_fee_discount_description: 'Clima Ruim',
      payment_method_used: 'PIX', expiration_date: 4.day.from_now , status: :confirmed_buffet)



      login_as(client0, scope: :user_client)
      visit root_path
      click_on 'Meus Pedidos'
      click_on 'ABCF1111'
      click_button 'Confirmar pedido'

      # Assert
      expect(page).to have_content 'Pedido confirmado com sucesso'
      expect(page).to have_content 'ABCF1111 - Pedido confirmado'
    end


    it 'e tenta Confirma um pedido fora da data limite' do
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
      event:event0, user_client:client0, extra_fee_discount: '200', extra_fee_discount_description: 'Clima Ruim',
      payment_method_used: 'PIX', expiration_date: Date.today-3 , status: :confirmed_buffet)

      login_as(client0, scope: :user_client)
      visit root_path
      click_on 'Meus Pedidos'
      click_on 'ABCF1111'

      # Assert
      expect(page).not_to have_content  'Confirmar pedido'
      expect(page).to have_content  'A data-limite para a confirmação já passou!'
    end

    it 'e cancelar um pedido que aguardar sua Confirmação' do
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
      event:event0, user_client:client0, extra_fee_discount: '200', extra_fee_discount_description: 'Clima Ruim',
      payment_method_used: 'PIX', expiration_date: 4.day.from_now , status: :confirmed_buffet)



      login_as(client0, scope: :user_client)
      visit root_path
      click_on 'Meus Pedidos'
      click_on 'ABCF1111'
      click_on 'Cancelar pedido'

      # Assert
      expect(page).to have_content 'Pedido cancelado com sucesso'
      expect(page).to have_content 'ABCF1111 - Pedido cancelado'
    end
  end
end
