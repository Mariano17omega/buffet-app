require 'rails_helper'

describe 'Usuario visitante' do
  context 'visita tela inicial' do
    it 'e vê o nome, a cidade e estado de todos os buffets cadastrados' do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Buffet FFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '97990518000151',
                      contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                      district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                      description: 'Buffet para festas fantasticas', playment_methods: 'PIX', user_owner: user_owner_0 )

      user_owner_1 = UserOwner.create!(email: 'cc@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Buffet da C.C.', corporate_name: 'Buffet Zero' ,cnpj: '44715046000162',
                      contact_phone: '88969721936', contact_email: 'buffetcc@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'PA', city: 'Belém', cep: '4522-9968',
                      description: 'Buffet para festas unicas', playment_methods: 'PIX', user_owner: user_owner_1 )

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
      Buffet.create!( brand_name: 'Buffet FFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '97990518000151',
                      contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                      district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                      description: 'Buffet para festas fantasticas', playment_methods: 'PIX', user_owner: user_owner_0 )

      user_owner_1 = UserOwner.create!(email: 'cc@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Buffet da C.C.', corporate_name: 'Buffet Zero' ,cnpj: '44715046000162',
                      contact_phone: '88969721936', contact_email: 'buffetcc@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'PA', city: 'Belém', cep: '4522-9968',
                      description: 'Buffet para festas unicas', playment_methods: 'PIX', user_owner: user_owner_1 )

      # Act
      visit root_path
      click_on 'Buffet Zero'
      # Assert
      expect(page).not_to have_content 'Buffet Zero'
      expect(page).to have_content 'Buffet da C.C.'
      expect(page).to have_content 'CNPJ: 44715046000162'
      expect(page).to have_content 'Telefone para contato: 88969721936'
      expect(page).to have_content 'E-mail para contato: buffetcc@gmail.com'
      expect(page).to have_content 'Endereço: Rua dos dois'

    end
  end

  context 'visita tela detalhes de um buffet' do
    it 'e vê a lista de todos os tipos de eventos que o buffet oferece' do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      buffet_0 =Buffet.create!( brand_name: 'Buffet FFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '97990518000151',
                      contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                      district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                      description: 'Buffet para festas fantasticas', playment_methods: 'PIX', user_owner: user_owner_0 )

      Event.create!(name:'Festa da B2' ,description:'Festa de androids', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_0.id)
      Event.create!(name:'Festa do ZERO' ,description:'Festa de Elevens', min_guests:'10', max_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_0.id)
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
      buffet_0 =Buffet.create!( brand_name: 'Buffet FFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '97990518000151',
                      contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                      district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                      description: 'Buffet para festas fantasticas', playment_methods: 'PIX', user_owner: user_owner_0 )

      Event.create!(name:'Festa da B2' ,description:'Festa de androids', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_0.id)
      Event.create!(name:'Festa do ZERO' ,description:'Festa de Elevens', min_guests:'10', max_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_0.id)
      # Act
      visit root_path
      click_on 'Buffet Fantasticos'
      click_on 'Festa da B2'
      # Assert
      expect(page).to have_content 'Festa da B2'
      expect(page).to have_content 'Festa de androids'
      expect(page).to have_content 'Quantidade mínima de convidados: 1'
      expect(page).to have_content 'Quantidade máxima de convidados: 10'
      expect(page).to have_content 'Duração: 120'
      expect(page).to have_content 'Cardápio: Comida'
      expect(page).to have_content 'Bebidas alcoólicas: Sim'
      expect(page).to have_content 'Decoração: Sim'
      expect(page).to have_content 'Exclusivo no endereço do buffet: Não'
      expect(page).to have_content 'Serviço: valet'

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
      Buffet.create!( brand_name: 'C.C. Buffets', corporate_name: 'Buffet Zero' ,cnpj: '44715046000162',
                      contact_phone: '88969721936', contact_email: 'buffetcc@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'SP', city: 'São Paulo', cep: '4522-9968',
                      description: 'Buffet para festas', playment_methods: 'PIX', user_owner: user_owner_0 )
      Event.create!(name:'Festa AB' ,description:'Festa para letras', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: user_owner_0.id)
      Event.create!(name:'Festa ABC' ,description:'Festa para muitas letras', min_guests:'10', max_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: user_owner_0.id)

      user_owner_1 = UserOwner.create!(email: 'b@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Abc Buffets', corporate_name: 'Corporate abc' ,cnpj: '447150460540162',
                      contact_phone: '88969755936', contact_email: 'b@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'PA', city: 'Belém', cep: '4522-8868',
                      description: 'Buffets unicos', playment_methods: 'PIX', user_owner: user_owner_1 )
      Event.create!(name:'Festa DFK' ,description:'Festa para letras As', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: user_owner_1.id)
      Event.create!(name:'Festa FES' ,description:'Festa para muitas letras Bs', min_guests:'10', max_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: user_owner_1.id)

      user_owner_2 = UserOwner.create!(email: 'c@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Bcd Buffets', corporate_name: 'Corporate bca' ,cnpj: '44235046000162',
                      contact_phone: '88969921936', contact_email: 'c@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'PA', city: 'Santarem', cep: '4522-9900',
                      description: 'Festas festas', playment_methods: 'PIX', user_owner: user_owner_2 )
      Event.create!(name:'Festa CDEFS' ,description:'Festa para letras diferentes ', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: user_owner_0.id)
      Event.create!(name:'Festa AW' ,description:'Festa para muitas letras diferentes', min_guests:'10', max_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: user_owner_2.id)

      user_owner_3 = UserOwner.create!(email: 'd@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Def Buffets', corporate_name: 'Corporate def' ,cnpj: '447150460001652',
                      contact_phone: '88969777936', contact_email: 'd@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'AM', city: 'Manaus', cep: '4022-9968',
                      description: 'Buffet Otimo', playment_methods: 'PIX', user_owner: user_owner_3 )
      Event.create!(name:'Festa DEF' ,description:'Festa para letras D', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: user_owner_3.id)
      Event.create!(name:'Festa E' ,description:'Festa para muitas letras Ds', min_guests:'10', max_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: user_owner_3.id)


      user_owner_4 = UserOwner.create!(email: 'm@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Mno Buffets', corporate_name: 'Corporate mno' ,cnpj: '447150460230162',
                      contact_phone: '88119721936', contact_email: 'm@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'AM', city: 'Itacoatiara', cep: '4522-9888',
                      description: 'Buffet fantasia', playment_methods: 'PIX', user_owner: user_owner_4 )
      Event.create!(name:'Festa 4' ,description:'Festa para Numeros', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: user_owner_4.id)
      Event.create!(name:'Festa A4' ,description:'Festa para muitas letras e numeros', min_guests:'10', max_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: user_owner_4.id)

      user_owner_5 = UserOwner.create!(email: 'z@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'zz Buffets', corporate_name: 'Corporate zz' ,cnpj: '44643046000162',
                      contact_phone: '88963321936', contact_email: 'z@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'AM', city: 'Manacapuru', cep: '2222-9968',
                      description: 'Buffet para eventos', playment_methods: 'PIX', user_owner: user_owner_5 )
      Event.create!(name:'Festa L' ,description:'Festa para letras Ls', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: user_owner_5.id)
      Event.create!(name:'Festa ML' ,description:'Festa para letras Ms', min_guests:'10', max_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: user_owner_5.id)

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
      Buffet.create!( brand_name: 'C.C. Buffets', corporate_name: 'Buffet Zero' ,cnpj: '44715046000162',
                      contact_phone: '88969721936', contact_email: 'buffetcc@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'SP', city: 'São Paulo', cep: '4522-9968',
                      description: 'Buffet para festas', playment_methods: 'PIX', user_owner: user_owner_0 )
      Event.create!(name:'Festa AB' ,description:'Festa para letras', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: user_owner_0.id)
      Event.create!(name:'Festa ABC' ,description:'Festa para muitas letras', min_guests:'10', max_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: user_owner_0.id)

      user_owner_1 = UserOwner.create!(email: 'b@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Abc Buffets', corporate_name: 'Corporate abc' ,cnpj: '447150460540162',
                      contact_phone: '88969755936', contact_email: 'b@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'PA', city: 'Belém', cep: '4522-8868',
                      description: 'Buffets unicos', playment_methods: 'PIX', user_owner: user_owner_1 )
      Event.create!(name:'Festa DFK' ,description:'Festa para letras As', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: user_owner_1.id)
      Event.create!(name:'Festa FES' ,description:'Festa para muitas letras Bs', min_guests:'10', max_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: user_owner_1.id)

      user_owner_2 = UserOwner.create!(email: 'c@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Bcd Buffets', corporate_name: 'Corporate bca' ,cnpj: '44235046000162',
                      contact_phone: '88969921936', contact_email: 'c@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'PA', city: 'Santarem', cep: '4522-9900',
                      description: 'Festas festas', playment_methods: 'PIX', user_owner: user_owner_2 )
      Event.create!(name:'Festa CDEFS' ,description:'Festa para letras diferentes ', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: user_owner_0.id)
      Event.create!(name:'Festa AW' ,description:'Festa para muitas letras diferentes', min_guests:'10', max_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: user_owner_2.id)

      user_owner_3 = UserOwner.create!(email: 'd@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Def Buffets', corporate_name: 'Corporate def' ,cnpj: '447150460001652',
                      contact_phone: '88969777936', contact_email: 'd@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'AM', city: 'Manaus', cep: '4022-9968',
                      description: 'Buffet Otimo', playment_methods: 'PIX', user_owner: user_owner_3 )
      Event.create!(name:'Festa DEF' ,description:'Festa para letras D', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: user_owner_3.id)
      Event.create!(name:'Festa E' ,description:'Festa para muitas letras Ds', min_guests:'10', max_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: user_owner_3.id)


      user_owner_4 = UserOwner.create!(email: 'm@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Mno Buffets', corporate_name: 'Corporate mno' ,cnpj: '447150460230162',
                      contact_phone: '88119721936', contact_email: 'm@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'AM', city: 'Itacoatiara', cep: '4522-9888',
                      description: 'Buffet fantasia', playment_methods: 'PIX', user_owner: user_owner_4 )
      Event.create!(name:'Festa 4' ,description:'Festa para Numeros', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: user_owner_4.id)
      Event.create!(name:'Festa A4' ,description:'Festa para muitas letras e numeros', min_guests:'10', max_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: user_owner_4.id)

      user_owner_5 = UserOwner.create!(email: 'z@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'zz Buffets', corporate_name: 'Corporate zz' ,cnpj: '44643046000162',
                      contact_phone: '88963321936', contact_email: 'z@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'AM', city: 'Manacapuru', cep: '2222-9968',
                      description: 'Buffet para eventos', playment_methods: 'PIX', user_owner: user_owner_5 )
      Event.create!(name:'Festa L' ,description:'Festa para letras Ls', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: user_owner_5.id)
      Event.create!(name:'Festa ML' ,description:'Festa para letras Ms', min_guests:'10', max_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: user_owner_5.id)

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
      Buffet.create!( brand_name: 'C.C. Buffets', corporate_name: 'Buffet Zero' ,cnpj: '44715046000162',
                      contact_phone: '88969721936', contact_email: 'buffetcc@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'SP', city: 'São Paulo', cep: '4522-9968',
                      description: 'Buffet para festas', playment_methods: 'PIX', user_owner: user_owner_0 )
      Event.create!(name:'Festa AB' ,description:'Festa para letras', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: user_owner_0.id)
      Event.create!(name:'Festa ABC' ,description:'Festa para muitas letras', min_guests:'10', max_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: user_owner_0.id)

      user_owner_1 = UserOwner.create!(email: 'b@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Abc Buffets', corporate_name: 'Corporate abc' ,cnpj: '447150460540162',
                      contact_phone: '88969755936', contact_email: 'b@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'PA', city: 'Belém', cep: '4522-8868',
                      description: 'Buffets unicos', playment_methods: 'PIX', user_owner: user_owner_1 )
      Event.create!(name:'Festa DFK' ,description:'Festa para letras As', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: user_owner_1.id)
      Event.create!(name:'Festa FES' ,description:'Festa para muitas letras Bs', min_guests:'10', max_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: user_owner_1.id)

      user_owner_2 = UserOwner.create!(email: 'c@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Bcd Buffets', corporate_name: 'Corporate bca' ,cnpj: '44235046000162',
                      contact_phone: '88969921936', contact_email: 'c@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'PA', city: 'Santarem', cep: '4522-9900',
                      description: 'Festas festas', playment_methods: 'PIX', user_owner: user_owner_2 )
      Event.create!(name:'Festa CDEFS' ,description:'Festa para letras diferentes ', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: user_owner_0.id)
      Event.create!(name:'Festa AW' ,description:'Festa para muitas letras diferentes', min_guests:'10', max_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: user_owner_2.id)

      user_owner_3 = UserOwner.create!(email: 'd@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Def Buffets', corporate_name: 'Corporate def' ,cnpj: '447150460001652',
                      contact_phone: '88969777936', contact_email: 'd@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'AM', city: 'Manaus', cep: '4022-9968',
                      description: 'Buffet Otimo', playment_methods: 'PIX', user_owner: user_owner_3 )
      Event.create!(name:'Festa DEF' ,description:'Festa para letras D', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: user_owner_3.id)
      Event.create!(name:'Festa E' ,description:'Festa para muitas letras Ds', min_guests:'10', max_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: user_owner_3.id)


      user_owner_4 = UserOwner.create!(email: 'm@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Mno Buffets', corporate_name: 'Corporate mno' ,cnpj: '447150460230162',
                      contact_phone: '88119721936', contact_email: 'm@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'AM', city: 'Manaus', cep: '4522-9888',
                      description: 'Buffet fantasia', playment_methods: 'PIX', user_owner: user_owner_4 )
      Event.create!(name:'Festa 4' ,description:'Festa para Numeros', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: user_owner_4.id)
      Event.create!(name:'Festa A4' ,description:'Festa para muitas letras e numeros', min_guests:'10', max_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: user_owner_4.id)

      user_owner_5 = UserOwner.create!(email: 'z@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'zz Buffets', corporate_name: 'Corporate zz' ,cnpj: '44643046000162',
                      contact_phone: '88963321936', contact_email: 'z@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'AM', city: 'Manaus', cep: '2222-9968',
                      description: 'Buffet para eventos', playment_methods: 'PIX', user_owner: user_owner_5 )
      Event.create!(name:'Festa L' ,description:'Festa para letras Ls', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: user_owner_5.id)
      Event.create!(name:'Festa ML' ,description:'Festa para letras Ms', min_guests:'10', max_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: user_owner_5.id)
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
