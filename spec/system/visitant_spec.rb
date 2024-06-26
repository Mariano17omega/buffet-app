require 'rails_helper'

describe 'Usuario visitante' do
  context 'visita tela inicial' do
    it 'e vê o nome, a cidade e estado de todos os buffets cadastrados' do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Buffet FFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '17199662000135',
                      contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                      district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                      description: 'Buffet para festas fantasticas', user_owner: user_owner_0 , payment_method_attributes:
                      { cash: 'true', credit_card: 'true', debit_card: 'false', bank_transfer: 'true', paypal: 'false',
                      check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' })

      user_owner_1 = UserOwner.create!(email: 'cc@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Buffet da C.C.', corporate_name: 'Buffet Zero' ,cnpj: '50144657000109',
                      contact_phone: '88969721936', contact_email: 'buffetcc@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'PA', city: 'Belém', cep: '4522-9968',
                      description: 'Buffet para festas unicas', user_owner: user_owner_1 , payment_method_attributes:
                      { cash: 'true', credit_card: 'true', debit_card: 'false', bank_transfer: 'true', paypal: 'false',
                      check: 'true', pix: 'false', bitcoin: 'true', google_pay: 'true' } )

      # Act
      visit root_path
      # Assert
      expect(page).to have_content 'Buffet Zero'
      expect(page).to have_content 'Belém'
      expect(page).to have_content 'PA'
      expect(page).to have_content 'Buffet Fantasticos'
      expect(page).to have_content 'Manaus'
      expect(page).to have_content 'AM'
    end

    it 'clicar no nome do buffet e vê os detalhes' do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Buffet FFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '20633352000191',
                      contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                      district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                      description: 'Buffet para festas fantasticas', user_owner: user_owner_0 , payment_method_attributes:
                      { cash: 'true', credit_card: 'true', debit_card: 'false', bank_transfer: 'true', paypal: 'false',
                      check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' })

      user_owner_1 = UserOwner.create!(email: 'cc@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Buffet da C.C.', corporate_name: 'Buffet Zero' ,cnpj: '26307788000177',
                      contact_phone: '88969721936', contact_email: 'buffetcc@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'PA', city: 'Belém', cep: '4522-9968',
                      description: 'Buffet para festas unicas',  user_owner: user_owner_1 , payment_method_attributes:
                      { cash: 'true', credit_card: 'true', debit_card: 'true', bank_transfer: 'true', paypal: 'false',
                      check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' })

      # Act
      visit root_path
      click_on 'Buffet Zero'
      # Assert
      expect(page).not_to have_content 'Buffet Zero'
      expect(page).to have_content 'Buffet da C.C.'
      expect(page).to have_content 'CNPJ: 26307788000177'
      expect(page).to have_content 'Telefone para contato: 88969721936'
      expect(page).to have_content 'E-mail para contato: buffetcc@gmail.com'
      expect(page).to have_content 'Endereço: Rua dos dois'

    end
  end

  context 'visita tela detalhes de um buffet' do
    it 'e vê a lista de todos os tipos de eventos que o buffet oferece' do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      buffet_0 =Buffet.create!( brand_name: 'Buffet FFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '51951768000181',
                      contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                      district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                      description: 'Buffet para festas fantasticas', user_owner: user_owner_0 , payment_method_attributes:
                      { cash: 'false', credit_card: 'true', debit_card: 'true', bank_transfer: 'true', paypal: 'false',
                      check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' })

      Event.create!(name:'Festa da B2' ,description:'Festa de androids', min_guests:'110',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_0.id, price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      Event.create!(name:'Festa do ZERO' ,description:'Festa de Elevens', min_guests:'111',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_0.id, price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      # Act
      visit root_path
      click_on 'Buffet Fantasticos'

      # Assert
      expect(page).to have_content 'Festa do ZERO'
      expect(page).to have_content 'Festa da B2'
    end

    it 'e vê os detalhes de um evento de um Buffet' do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      buffet_0 =Buffet.create!( brand_name: 'Buffet FFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '72374354000107',
                      contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                      district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                      description: 'Buffet para festas fantasticas', user_owner: user_owner_0 ,payment_method_attributes:
                      { cash: 'true', credit_card: 'true', debit_card: 'false', bank_transfer: 'true', paypal: 'false',
                      check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' })

      Event.create!(name:'Festa da B2' ,description:'Festa de androids', min_guests:'111',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_0.id, price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      Event.create!(name:'Festa do ZERO' ,description:'Festa de Elevens', min_guests:'110',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_0.id, price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      # Act
      visit root_path
      click_on 'Buffet Fantasticos'
      click_on 'Festa da B2'
      # Assert
      expect(page).to have_content 'Festa da B2'
      expect(page).to have_content 'Festa de androids'
      expect(page).to have_content 'Quantidade de convidados: 111'
      expect(page).to have_content 'Duração: 120'
      expect(page).to have_content 'Cardápio: Comida'
      expect(page).to have_content 'Bebidas alcoólicas: Sim'
      expect(page).to have_content 'Decoração: Sim'
      expect(page).to have_content 'Exclusivo no endereço do buffet: Não'
      expect(page).to have_content 'Estacionamento: com serviço valet'

    end
  end
  context 'visita tela inicial' do
    it 'e vê o campo de busca' do
      # Arrange
      # Act
      visit root_path
      within 'nav' do
        expect(page).to have_field 'Buscar'
        expect(page).to have_button 'Buscar'
      end
      # Assert
    end

    it 'e faz uma busca por evento' do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'a@example.com', password: 'senha123' )
      buffet_0 = Buffet.create!(brand_name: 'C.C. Buffets', corporate_name: 'Buffet Zero' ,cnpj: '59648274000134',
                      contact_phone: '88969721936', contact_email: 'buffetcc@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'SP', city: 'São Paulo', cep: '4522-9968',
                      description: 'Buffet para festas', user_owner: user_owner_0 , payment_method_attributes:
                      { cash: 'true', credit_card: 'true', debit_card: 'false', bank_transfer: 'true', paypal: 'false',
                      check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' })
      Event.create!(name:'Festa AB' ,description:'Festa para letras', min_guests:'20',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_0.id, price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      Event.create!(name:'Festa ABC' ,description:'Festa para muitas letras', min_guests:'60',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_0.id, price_attributes: {price_base_weekdays: '1200', price_add_weekdays: '100',
                    price_overtime_weekdays: '150', price_base_weekend: '5000', price_add_weekend: '500.0',
                    price_overtime_weekend: '400'})

      user_owner_1 = UserOwner.create!(email: 'b@example.com', password: 'senha123' )
      buffet_1 = Buffet.create!( brand_name: 'Abc Buffets', corporate_name: 'Corporate abc' ,cnpj: '36715525000150',
                      contact_phone: '88969755936', contact_email: 'b@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'PA', city: 'Belém', cep: '4522-8868',
                      description: 'Buffets unicos', user_owner: user_owner_1 , payment_method_attributes:
                      { cash: 'false', credit_card: 'true', debit_card: 'false', bank_transfer: 'true', paypal: 'false',
                      check: 'true', pix: 'true', bitcoin: 'false', google_pay: 'false' } )
      Event.create!(name:'Festa DFK' ,description:'Festa para letras As', min_guests:'90',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_1.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      Event.create!(name:'Festa FES' ,description:'Festa para muitas letras Bs', min_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_1.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})

      user_owner_2 = UserOwner.create!(email: 'c@example.com', password: 'senha123' )
      buffet_2 = Buffet.create!( brand_name: 'Bcd Buffets', corporate_name: 'Corporate bca' ,cnpj: '72340158000111',
                      contact_phone: '88969921936', contact_email: 'c@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'PA', city: 'Santarem', cep: '4522-9900',
                      description: 'Festas festas', user_owner: user_owner_2 , payment_method_attributes:
                      { cash: 'true', credit_card: 'true', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                      check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'true' })
      Event.create!(name:'Festa CDEFS' ,description:'Festa para letras diferentes ', min_guests:'50',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_2.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      Event.create!(name:'Festa AW' ,description:'Festa para muitas letras diferentes', min_guests:'40',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_2.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})

      user_owner_3 = UserOwner.create!(email: 'd@example.com', password: 'senha123' )
      buffet_3 = Buffet.create!( brand_name: 'Def Buffets', corporate_name: 'Corporate def' ,cnpj: '12172266000109',
                      contact_phone: '88969777936', contact_email: 'd@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'AM', city: 'Manaus', cep: '4022-9968',
                      description: 'Buffet Otimo', user_owner: user_owner_3 , payment_method_attributes:
                      { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'false', paypal: 'false',
                      check: 'false', pix: 'true', bitcoin: 'true', google_pay: 'false' })
      Event.create!(name:'Festa DEF' ,description:'Festa para letras D', min_guests:'77',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_3.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      Event.create!(name:'Festa E' ,description:'Festa para muitas letras Ds', min_guests:'222',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_3.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})


      user_owner_4 = UserOwner.create!(email: 'm@example.com', password: 'senha123' )
      buffet_4 = Buffet.create!( brand_name: 'Mno Buffets', corporate_name: 'Corporate mno' ,cnpj: '12621176000140',
                      contact_phone: '88119721936', contact_email: 'm@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'AM', city: 'Itacoatiara', cep: '4522-9888',
                      description: 'Buffet fantasia',  user_owner: user_owner_4 , payment_method_attributes:
                      { cash: 'true', credit_card: 'true', debit_card: 'false', bank_transfer: 'true', paypal: 'false',
                      check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'true' })
      Event.create!(name:'Festa 4' ,description:'Festa para Numeros', min_guests:'100',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_4.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      Event.create!(name:'Festa A4' ,description:'Festa para muitas letras e numeros', min_guests:'102',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_4.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})

      user_owner_5 = UserOwner.create!(email: 'z@example.com', password: 'senha123' )
      buffet_5 = Buffet.create!( brand_name: 'zz Buffets', corporate_name: 'Corporate zz' ,cnpj: '55867259000126',
                      contact_phone: '88963321936', contact_email: 'z@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'AM', city: 'Manacapuru', cep: '2222-9968',
                      description: 'Buffet para eventos',  user_owner: user_owner_5 , payment_method_attributes:
                      { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                      check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' })
      Event.create!(name:'Festa L' ,description:'Festa para letras Ls', min_guests:'100',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_5.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      Event.create!(name:'Festa ML' ,description:'Festa para letras Ms', min_guests:'130',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_5.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})

      # Act
      visit root_path
      within 'nav' do
        fill_in 'Buscar',	with: 'Festa'
        click_on 'Buscar'
      end
      # Assert
      expect(page).to have_content 'Resultados da Busca por: Festa'
      expect(page).to have_content 'Abc Buffets'
      expect(page).to have_content 'Bcd Buffets'
      expect(page).to have_content 'C.C. Buffets'
      expect(page).to have_content 'Def Buffets'
      expect(page).to have_content 'Mno Buffets'
      expect(page).to have_content 'zz Buffets'
    end


    it 'e faz uma busca por Buffet' do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'a@example.com', password: 'senha123' )
      buffet_0 = Buffet.create!( brand_name: 'C.C. Buffets', corporate_name: 'Buffet Zero' ,cnpj: '59648274000134',
                      contact_phone: '88969721936', contact_email: 'buffetcc@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'SP', city: 'São Paulo', cep: '4522-9968',
                      description: 'Buffet para festas', user_owner: user_owner_0 , payment_method_attributes:
                      { cash: 'true', credit_card: 'true', debit_card: 'false', bank_transfer: 'true', paypal: 'false',
                      check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' })
      Event.create!(name:'Festa AB' ,description:'Festa para letras', min_guests:'140',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_0.id, price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      Event.create!(name:'Festa ABC' ,description:'Festa para muitas letras', min_guests:'130',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_0.id, price_attributes: {price_base_weekdays: '1200', price_add_weekdays: '100',
                    price_overtime_weekdays: '150', price_base_weekend: '5000', price_add_weekend: '500.0',
                    price_overtime_weekend: '400'})

      user_owner_1 = UserOwner.create!(email: 'b@example.com', password: 'senha123' )
      buffet_1 = Buffet.create!( brand_name: 'Abc Buffets', corporate_name: 'Corporate abc' ,cnpj: '36715525000150',
                      contact_phone: '88969755936', contact_email: 'b@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'PA', city: 'Belém', cep: '4522-8868',
                      description: 'Buffets unicos', user_owner: user_owner_1 , payment_method_attributes:
                      { cash: 'false', credit_card: 'true', debit_card: 'false', bank_transfer: 'true', paypal: 'false',
                      check: 'true', pix: 'true', bitcoin: 'false', google_pay: 'false' } )
      Event.create!(name:'Festa DFK' ,description:'Festa para letras As', min_guests:'144',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_1.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      Event.create!(name:'Festa FES' ,description:'Festa para muitas letras Bs', min_guests:'140',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_1.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})

      user_owner_2 = UserOwner.create!(email: 'c@example.com', password: 'senha123' )
      buffet_2 = Buffet.create!( brand_name: 'Bcd Buffets', corporate_name: 'Corporate bca' ,cnpj: '72340158000111',
                      contact_phone: '88969921936', contact_email: 'c@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'PA', city: 'Santarem', cep: '4522-9900',
                      description: 'Festas festas', user_owner: user_owner_2 , payment_method_attributes:
                      { cash: 'true', credit_card: 'true', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                      check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'true' })
      Event.create!(name:'Festa CDEFS' ,description:'Festa para letras diferentes ', min_guests:'155',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_2.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      Event.create!(name:'Festa AW' ,description:'Festa para muitas letras diferentes', min_guests:'107',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_2.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})

      user_owner_3 = UserOwner.create!(email: 'd@example.com', password: 'senha123' )
      buffet_3 = Buffet.create!( brand_name: 'Def Buffets', corporate_name: 'Corporate def' ,cnpj: '12172266000109',
                      contact_phone: '88969777936', contact_email: 'd@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'AM', city: 'Manaus', cep: '4022-9968',
                      description: 'Buffet Otimo', user_owner: user_owner_3 , payment_method_attributes:
                      { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'false', paypal: 'false',
                      check: 'false', pix: 'true', bitcoin: 'true', google_pay: 'false' })
      Event.create!(name:'Festa DEF' ,description:'Festa para letras D', min_guests:'190',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_3.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      Event.create!(name:'Festa E' ,description:'Festa para muitas letras Ds', min_guests:'160',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_3.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})


      user_owner_4 = UserOwner.create!(email: 'm@example.com', password: 'senha123' )
      buffet_4 = Buffet.create!( brand_name: 'Mno Buffets', corporate_name: 'Corporate mno' ,cnpj: '12621176000140',
                      contact_phone: '88119721936', contact_email: 'm@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'AM', city: 'Itacoatiara', cep: '4522-9888',
                      description: 'Buffet fantasia',  user_owner: user_owner_4 , payment_method_attributes:
                      { cash: 'true', credit_card: 'true', debit_card: 'false', bank_transfer: 'true', paypal: 'false',
                      check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'true' })
      Event.create!(name:'Festa 4' ,description:'Festa para Numeros', min_guests:'121',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_4.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      Event.create!(name:'Festa A4' ,description:'Festa para muitas letras e numeros', min_guests:'101',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_4.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})

      user_owner_5 = UserOwner.create!(email: 'z@example.com', password: 'senha123' )
      buffet_5 = Buffet.create!( brand_name: 'zz Buffets', corporate_name: 'Corporate zz' ,cnpj: '55867259000126',
                      contact_phone: '88963321936', contact_email: 'z@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'AM', city: 'Manacapuru', cep: '2222-9968',
                      description: 'Buffet para eventos',  user_owner: user_owner_5 , payment_method_attributes:
                      { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                      check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' })
      Event.create!(name:'Festa L' ,description:'Festa para letras Ls', min_guests:'122',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_5.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      Event.create!(name:'Festa ML' ,description:'Festa para letras Ms', min_guests:'160',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_5.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})


      # Act
      visit root_path
      within 'nav' do
        fill_in 'Buscar',	with: 'Buffet'
        click_on 'Buscar'
      end
      # Assert
      expect(page).to have_content 'Resultados da Busca por: Buffet'
      expect(page).to have_content 'Abc Buffets'
      expect(page).to have_content 'Bcd Buffets'
      expect(page).to have_content 'C.C. Buffets'
      expect(page).to have_content 'Def Buffets'
      expect(page).to have_content 'Mno Buffets'
      expect(page).to have_content 'zz Buffets'
    end

    it 'e faz uma busca por cidade' do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'a@example.com', password: 'senha123' )
      buffet_0 = Buffet.create!( brand_name: 'C.C. Buffets', corporate_name: 'Buffet Zero' ,cnpj: '88802612000149',
                      contact_phone: '88969721936', contact_email: 'buffetcc@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'SP', city: 'São Paulo', cep: '4522-9968',
                      description: 'Buffet para festas',  user_owner: user_owner_0 , payment_method_attributes:
                      { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                      check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' } )
      Event.create!(name:'Festa AB' ,description:'Festa para letras', min_guests:'110',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_0.id, price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      Event.create!(name:'Festa ABC' ,description:'Festa para muitas letras', min_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_0.id, price_attributes: {price_base_weekdays: '1200', price_add_weekdays: '100',
                    price_overtime_weekdays: '150', price_base_weekend: '5000', price_add_weekend: '500.0',
                    price_overtime_weekend: '400'})

      user_owner_1 = UserOwner.create!(email: 'b@example.com', password: 'senha123' )
      buffet_1 = Buffet.create!(brand_name: 'Abc Buffets', corporate_name: 'Corporate abc' ,cnpj: '56933756000148',
                                contact_phone: '88969755936', contact_email: 'b@gmail.com',  address: 'Rua dos dois',
                                district: 'Bairro fantasia', state: 'PA', city: 'Belém', cep: '4522-8868',
                                description: 'Buffets unicos',   user_owner: user_owner_1 , payment_method_attributes:
                                { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                                check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' } )
      Event.create!(name:'Festa DFK' ,description:'Festa para letras As', min_guests:'100',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_1.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      Event.create!(name:'Festa FES' ,description:'Festa para muitas letras Bs', min_guests:'120',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_1.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})

      user_owner_2 = UserOwner.create!(email: 'c@example.com', password: 'senha123' )
      buffet_2 = Buffet.create!(brand_name: 'Bcd Buffets', corporate_name: 'Corporate bca' ,cnpj: '80834870000103',
                                contact_phone: '88969921936', contact_email: 'c@gmail.com',  address: 'Rua dos dois',
                                district: 'Bairro fantasia', state: 'PA', city: 'Santarem', cep: '4522-9900',
                                description: 'Festas festas',   user_owner: user_owner_2 , payment_method_attributes:
                                { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                                check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' })
      Event.create!(name:'Festa CDEFS' ,description:'Festa para letras diferentes ', min_guests:'50',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_2.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      Event.create!(name:'Festa AW' ,description:'Festa para muitas letras diferentes', min_guests:'70',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_2.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})

      user_owner_3 = UserOwner.create!(email: 'd@example.com', password: 'senha123' )
      buffet_3 = Buffet.create!(brand_name: 'Def Buffets', corporate_name: 'Corporate def' ,cnpj: '94595685000100',
                                contact_phone: '88969777936', contact_email: 'd@gmail.com',  address: 'Rua dos dois',
                                district: 'Bairro fantasia', state: 'AM', city: 'Manaus', cep: '4022-9968',
                                description: 'Buffet Otimo',   user_owner: user_owner_3 , payment_method_attributes:
                                { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                                check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' } )
      Event.create!(name:'Festa DEF' ,description:'Festa para letras D', min_guests:'90',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_3.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      Event.create!(name:'Festa E' ,description:'Festa para muitas letras Ds', min_guests:'200',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_3.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})


      user_owner_4 = UserOwner.create!(email: 'm@example.com', password: 'senha123' )
      buffet_4 = Buffet.create!(brand_name: 'Mno Buffets', corporate_name: 'Corporate mno' ,cnpj: '84728741000183',
                                contact_phone: '88119721936', contact_email: 'm@gmail.com',  address: 'Rua dos dois',
                                district: 'Bairro fantasia', state: 'AM', city: 'Manaus', cep: '4522-9888',
                                description: 'Buffet fantasia',   user_owner: user_owner_4 , payment_method_attributes:
                                { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                                check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' } )
      Event.create!(name:'Festa 4' ,description:'Festa para Numeros', min_guests:'150',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_4.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      Event.create!(name:'Festa A4' ,description:'Festa para muitas letras e numeros', min_guests:'107',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_4.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})

      user_owner_5 = UserOwner.create!(email: 'z@example.com', password: 'senha123' )
      buffet_5 = Buffet.create!(brand_name: 'zz Buffets', corporate_name: 'Corporate zz' ,cnpj: '54233350000127',
                                contact_phone: '88963321936', contact_email: 'z@gmail.com',  address: 'Rua dos dois',
                                district: 'Bairro fantasia', state: 'AM', city: 'Manaus', cep: '2222-9968',
                                description: 'Buffet para eventos',   user_owner: user_owner_5 , payment_method_attributes:
                                { cash: 'true', credit_card: 'false', debit_card: 'false', bank_transfer: 'true', paypal: 'true',
                                check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' } )
      Event.create!(name:'Festa L' ,description:'Festa para letras Ls', min_guests:'130',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_5.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      Event.create!(name:'Festa ML' ,description:'Festa para letras Ms', min_guests:'150',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_5.id , price_attributes: {price_base_weekdays: '1200',
                    price_add_weekdays: '100', price_overtime_weekdays: '150', price_base_weekend: '5000',
                    price_add_weekend: '500.0', price_overtime_weekend: '400'})
      # Act
      visit root_path
      within 'nav' do
        fill_in 'Buscar',	with: 'Manaus'
        click_on 'Buscar'
      end
      # Assert
      expect(page).to have_content 'Resultados da Busca por: Manaus'
      expect(page).not_to have_content 'Abc Buffets'
      expect(page).not_to have_content 'Bcd Buffets'
      expect(page).not_to have_content 'C.C. Buffets'
      expect(page).to have_content 'Def Buffets'
      expect(page).to have_content 'Mno Buffets'
      expect(page).to have_content 'zz Buffets'
    end
  end
end
