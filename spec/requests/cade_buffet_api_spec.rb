require 'rails_helper'

describe 'Cadê o Buffet API' do
  context 'GET /api/v1/buffets/:id -  A partir do ID de um buffet, fornece todos os detalhes do buffet exceto CNPJ e razão social' do
    it 'fornece todos os detalhes do buffet com sucesso' do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      buffet_0 =Buffet.create!(brand_name: 'Buffet FFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '41932876000153',
                              contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                              district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                              description: 'Buffet para festas fantasticas', user_owner: user_owner_0 , payment_method_attributes:
                              { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                              check: 'false', pix: 'true', bitcoin: 'false', google_pay: 'false' })

      # Act
      get "/api/v1/buffets/#{buffet_0.id}"
      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)

      expect(json_response['brand_name']).to eq 'Buffet FFs'
      expect(json_response['contact_phone']).to eq '55972662205'
      expect(json_response['contact_email']).to eq 'buffetfantastico@gmail.com'
      expect(json_response['address']).to eq 'Rua dos Buffets'
      expect(json_response['district']).to eq 'Bairro do Buffet Bonito'
      expect(json_response['state']).to eq  'AM'
      expect(json_response['city']).to eq 'Manaus'
      expect(json_response['cep']).to eq '2335-3434'
      expect(json_response['description']).to eq 'Buffet para festas fantasticas'
      expect(json_response.keys).not_to include 'corporate_name'
      expect(json_response.keys).not_to include 'cnpj'
      expect(json_response.keys).not_to include 'created_at'
      expect(json_response.keys).not_to include 'updated_at'

      expect(json_response['payment_method']['cash']).to eq true
      expect(json_response['payment_method']['credit_card']).to eq false
      expect(json_response['payment_method']['debit_card']).to eq false
      expect(json_response['payment_method']['bank_transfer']).to eq true
      expect(json_response['payment_method']['check']).to eq false
      expect(json_response['payment_method']['pix']).to eq true
      expect(json_response['payment_method']['bitcoin']).to eq false
      expect(json_response['payment_method']['google_pay']).to eq false

      expect(json_response['payment_method'].keys).not_to include 'created_at'
      expect(json_response['payment_method'].keys).not_to include 'updated_at'
    end

    it 'falha se não encontra o buffet' do
      # Arrange
      # Act
      get "/api/v1/buffets/666"
      # Assert
      expect(response).to have_http_status(404)

    end
  end

  context 'GET /api/v1/buffets/ -  Fornece uma listagem completa de buffets cadastrados na plataforma. ' do
    it 'lista os buffets em ordem alfabetica' do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'A Buffet', corporate_name: 'Buffet Fantasticos' ,cnpj: '41932876000153',
                      contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                      district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                      description: 'Buffet para festas fantasticas', user_owner: user_owner_0 , payment_method_attributes:
                      { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                      check: 'false', pix: 'true', bitcoin: 'false', google_pay: 'false' })

      user_owner_1 = UserOwner.create!(email: 'c@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'B Buffet', corporate_name: 'Corporate bca' ,cnpj: '80834870000103',
                      contact_phone: '88969921936', contact_email: 'c@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'PA', city: 'Santarem', cep: '4522-9900',
                      description: 'Festas festas',   user_owner: user_owner_1 , payment_method_attributes:
                      { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                      check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' })
      # Act
      get "/api/v1/buffets"
      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.class ).to eq Array
      expect(json_response.length ).to eq 2
      expect(json_response[0]['brand_name']).to eq 'A Buffet'
      expect(json_response[1]['brand_name']).to eq 'B Buffet'
    end

    it 'retornar vazio se não houver buffet' do
      # Arrange
      # Act
      get "/api/v1/buffets"
      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response ).to eq []
    end

    it 'GET /api/v1/buffets/search?query=:brand_name - retornar a busca pelo nome de um buffet' do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Orange B', corporate_name: 'Buffet Fantasticos' ,cnpj: '41932876000153',
                      contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                      district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                      description: 'Buffet para festas fantasticas', user_owner: user_owner_0 , payment_method_attributes:
                      { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                      check: 'false', pix: 'true', bitcoin: 'false', google_pay: 'false' })

      user_owner_1 = UserOwner.create!(email: 'c@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Orange A', corporate_name: 'Corporate bca' ,cnpj: '80834870000103',
                      contact_phone: '88969921936', contact_email: 'c@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'PA', city: 'Santarem', cep: '4522-9900',
                      description: 'Festas festas',   user_owner: user_owner_1 , payment_method_attributes:
                      { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                      check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' })

      # Act
      get "/api/v1/buffets/search?query=orange"

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response[0]['brand_name']).to eq 'Orange A'
      expect(json_response[1]['brand_name']).to eq 'Orange B'
    end
  end


  context 'GET /api/v1/buffets/:id/events - A partir do ID de um buffet, fornece uma lista com informações sobre os tipos de eventos disponíveis no buffet.' do
    it 'lista dos eventos de um buffet' do
      # Arrange
      user_owner_1 = UserOwner.create!(email: 'b@example.com', password: 'senha123' )
      buffet_0 = Buffet.create!(brand_name: 'Abc Buffets', corporate_name: 'Corporate abc' ,cnpj: '56933756000148',
                                contact_phone: '88969755936', contact_email: 'b@gmail.com',  address: 'Rua dos dois',
                                district: 'Bairro fantasia', state: 'PA', city: 'Belém', cep: '4522-8868',
                                description: 'Buffets unicos',   user_owner: user_owner_1 , payment_method_attributes:
                                { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                                check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' } )
      Event.create!(name:'Festa B' ,description:'Festa para letras As', min_guests:'100',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_0.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      Event.create!(name:'Festa A' ,description:'Festa para muitas letras Bs', min_guests:'120',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_0.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      # Act
      get "/api/v1/buffets/#{buffet_0.id}/events"

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response[0]['name']).to eq 'Festa A'
      expect(json_response[1]['name']).to eq 'Festa B'

    end
  end


  context 'POST /api/v1/events/availability - Informando um ID de um evento, a data do evento e a quantidade de convidados, deve ser possível verificar a disponibilidade para realizar um evento. ' do
    it 'em caso positivo, deve ser retornado o valor prévio do pedido' do
      # Arrange
      user_owner_1 = UserOwner.create!(email: 'b@example.com', password: 'senha123' )
      buffet_0 = Buffet.create!(brand_name: 'Abc Buffets', corporate_name: 'Corporate abc' ,cnpj: '56933756000148',
                                contact_phone: '88969755936', contact_email: 'b@gmail.com',  address: 'Rua dos dois',
                                district: 'Bairro fantasia', state: 'PA', city: 'Belém', cep: '4522-8868',
                                description: 'Buffets unicos',   user_owner: user_owner_1 , payment_method_attributes:
                                { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                                check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' } )
      event_0 = Event.create!( name:'Festa A' ,description:'Festa para muitas letras Bs', min_guests:'120',
                                duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                                event_location:'true', buffet_id: buffet_0.id , price_attributes: {price_base_weekdays: '1200',
                                price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                                price_add_weekend: '500.0', price_overtime_weekend: '400'})
      # Act
      date_event = 5.day.from_now.to_date#.strftime("%d-%m-%Y")
      post "/api/v1/events/availability", params:{event_id: event_0.id, date_event: date_event, num_guests: '200' }

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)

      if date_event.saturday? || date_event.sunday?
        expect(json_response).to eq 45000.0
      else
        expect(json_response).to eq 9200.0
      end


    end
  end

end
