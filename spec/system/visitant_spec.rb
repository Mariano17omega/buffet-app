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
end
