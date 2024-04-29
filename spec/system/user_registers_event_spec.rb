require 'rails_helper'

describe 'Usuario dono de buffet' do
  context 'acessar seu buffet' do
    it 'e acessar a tela para cadastra um evento' do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Buffet FFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '97990518000151',
                      contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                      district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                      description: 'Buffet para festas fantasticas', playment_methods: 'PIX', user_owner: user_owner_0 )

      # Act
      login_as(user_owner_0, scope: :user_owner)
      visit root_path
      click_on 'Buffet Fantasticos'
      click_on 'Novo Evento'
      # Assert
      expect(page).to have_content 'Nome'
      expect(page).to have_content 'Descrição'
      expect(page).to have_content 'Quantidade mínima de convidados'
      expect(page).to have_content 'Quantidade máxima de convidados'
      expect(page).to have_content 'Duração'
      expect(page).to have_content 'Cardápio'
      expect(page).to have_content 'Bebidas alcoólicas'
      expect(page).to have_content 'Decoração'
      expect(page).to have_content 'Serviço de valet'
      expect(page).to have_content 'O evento deve ser realizado exclusivamente no endereço do buffet'

    end

    it 'e cadastra um evento com sucesso' do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Buffet FFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '97990518000151',
                      contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                      district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                      description: 'Buffet para festas fantasticas', playment_methods: 'PIX', user_owner: user_owner_0 )

      # Act
      login_as(user_owner_0, scope: :user_owner)
      visit root_path
      click_on 'Buffet Fantasticos'
      click_on 'Novo Evento'
      fill_in 'Nome', with: 'Festa da B2'
      fill_in 'Descrição', with: 'Festa de androids'

      fill_in 'Quantidade mínima de convidados', with: '2'
      fill_in 'Quantidade máxima de convidados', with: '5'
      fill_in 'Duração', with: '60'
      fill_in 'Cardápio', with: 'Muita comida'
      check 'Bebidas alcoólicas'
      check 'Decoração'
      check 'Serviço de valet'
      check 'O evento deve ser realizado exclusivamente no endereço do buffet'
      click_button 'Cadastrar Evento'
      # Assert
      expect(page).to have_content 'Evento cadastrado com sucesso'
      expect(page).to have_content 'Buffet FFs'
      expect(page).to have_content 'Festa da B2'
      expect(page).to have_content 'Quantidade mínima de convidados: 2'
      expect(page).to have_content 'Quantidade máxima de convidados: 5'
      expect(page).to have_content 'Serviço: valet'
      expect(page).to have_content 'Exclusivo no endereço do buffet: Sim'
      expect(page).to have_content 'Decoração: Sim'
      expect(page).to have_content 'Bebidas alcoólicas: Sim'

    end
    it 'e tenta cadastra um evento faltando dados'  do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Buffet FFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '97990518000151',
                      contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                      district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                      description: 'Buffet para festas fantasticas', playment_methods: 'PIX', user_owner: user_owner_0 )

      # Act
      login_as(user_owner_0, scope: :user_owner)
      visit root_path
      click_on 'Buffet Fantasticos'
      click_on 'Novo Evento'

      fill_in 'Nome', with: ''
      fill_in 'Quantidade mínima de convidados', with: '2'
      fill_in 'Quantidade máxima de convidados', with: ''
      fill_in 'Duração', with: ''
      fill_in 'Cardápio', with: 'Muita comida'
      check 'Bebidas alcoólicas'
      check 'Decoração'
      click_button 'Cadastrar Evento'
      # Assert
      #
      #
      expect(page).to have_content 'Evento não cadastrado'
      expect(page).to have_content 'Descrição não pode ficar em branco'
      expect(page).to have_content 'Nome não pode ficar em branco'
      expect(page).to have_content 'Nome'
      expect(page).to have_content 'Descrição'
      expect(page).to have_content 'Quantidade mínima de convidados'
      expect(page).to have_content 'Quantidade máxima de convidados'

    end


    it 'e tenta cadastra um evento que já existe'  do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      buffet_0 =Buffet.create!( brand_name: 'Buffet FFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '97990518000151',
                      contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                      district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                      description: 'Buffet para festas fantasticas', playment_methods: 'PIX', user_owner: user_owner_0 )
      Event.create!(name:'Festa da B2' ,description:'Festa de androids', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_0.id)
      # Act
      login_as(user_owner_0, scope: :user_owner)
      visit root_path
      click_on 'Buffet Fantasticos'
      click_on 'Novo Evento'

      fill_in 'Nome', with: 'Festa da B2'
      fill_in 'Descrição', with: 'Festa de androids'
      fill_in 'Quantidade mínima de convidados', with: '2'
      fill_in 'Quantidade máxima de convidados', with: '5'
      fill_in 'Duração', with: '60'
      fill_in 'Cardápio', with: 'Muita comida'
      check 'Bebidas alcoólicas'
      check 'Decoração'
      check 'Serviço de valet'
      check 'O evento deve ser realizado exclusivamente no endereço do buffet'
      click_button 'Cadastrar Evento'
      # Assert
      expect(page).to have_content 'Evento não cadastrado'
      expect(page).to have_content 'Nome já está em uso'
      expect(page).to have_content 'Nome'
      expect(page).to have_content 'Descrição'
      expect(page).to have_content 'Quantidade mínima de convidados'
      expect(page).to have_content 'Quantidade máxima de convidados'

    end
    it 'e vê a sua lista de eventos' do
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
      login_as(user_owner_0, scope: :user_owner)
      visit root_path
      click_on 'Buffet Fantasticos'

      # Assert
      expect(page).to have_content 'Festa do ZERO'
      expect(page).to have_content 'Festa da B2'


    end
    it 'e acessar os detalhes de um evento' do
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
      login_as(user_owner_0, scope: :user_owner)
      visit root_path
      click_on 'Buffet Fantasticos'
      click_on 'Festa da B2'

      # Assert
      expect(page).to have_content 'Festa da B2'
      expect(page).to have_content 'Buffet FFs'
      expect(page).to have_content 'Festa de androids'

      expect(page).to have_content 'Quantidade mínima de convidados: 1'
      expect(page).to have_content 'Quantidade máxima de convidados: 10'
      expect(page).to have_content 'Duração: 120 min'
      expect(page).to have_content 'Cardápio: Comida'
      expect(page).to have_content 'Serviço: valet'
      expect(page).to have_content 'Exclusivo no endereço do buffet: Não'
      expect(page).to have_content 'Decoração: Sim'
      expect(page).to have_content 'Bebidas alcoólicas: Sim'


    end
    it 'e editar um evento' do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      buffet_0 =Buffet.create!( brand_name: 'Buffet FFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '97990518000151',
                      contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                      district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                      description: 'Buffet para festas fantasticas', playment_methods: 'PIX', user_owner: user_owner_0 )
      Event.create!(name:'Festa da B2' ,description:'Festa de androids', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_0.id)
      # Act
      login_as(user_owner_0, scope: :user_owner)
      visit root_path
      click_on 'Buffet Fantasticos'
      click_on 'Festa da B2'
      click_on 'Editar Evento'

      fill_in 'Nome', with: 'Festa da B2 e do 9S'
      fill_in 'Descrição', with: 'Festa para androids'
      fill_in 'Quantidade mínima de convidados', with: '2'
      fill_in 'Quantidade máxima de convidados', with: '20'
      click_button 'Cadastrar Evento'
      # Assert
      expect(page).to have_content 'Evento editado com sucesso'
      expect(page).to have_content 'Festa da B2 e do 9S'
      expect(page).to have_content 'Quantidade mínima de convidados: 2'
      expect(page).to have_content 'Quantidade máxima de convidados: 20'
    end
  end
end