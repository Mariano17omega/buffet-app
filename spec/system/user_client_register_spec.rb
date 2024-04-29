require 'rails_helper'


describe 'Usuario visita tela inicial' do
  context 'como cliente' do
    it 'e faz sua inscrição' do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Buffet FFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '97990518000151',
                      contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                      district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                      description: 'Buffet para festas fantasticas', playment_methods: 'PIX', user_owner: user_owner_0 )
      user_owner_1 = UserOwner.create!(email: 'cc@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Buffet da C.C.', corporate_name: 'Buffet Zero' ,cnpj: '44715046000162',
                      contact_phone: '88969721936', contact_email: 'buffetcc@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'AM', city: 'Manaus', cep: '4522-9968',
                      description: 'Buffet para festas unicas', playment_methods: 'PIX', user_owner: user_owner_1 )

      # Act
      visit root_path
      click_on 'Inscrição'
      click_on 'Sou Cliente'

      fill_in 'Nome', with: 'Lelouch Lamperouge'
      fill_in 'CPF', with: '24283839221'
      fill_in 'E-mail', with: 'll@gmail.com'
      fill_in 'Senha', with: 'mypassword'
      fill_in 'Confirmar senha', with: 'mypassword'

      within('form') do
        click_button 'Inscrever-se'
      end

      # Assert
      expect(page).to have_content 'Bem vindo! Você se registrou com sucesso.'
      expect(page).to have_content 'Buffet Fantasticos'
      expect(page).to have_content 'Buffet Zero'

    end
    it  'e faz sua inscrição usando um CPF único e válido.' do
    end

    it 'e faz o login com sucesso'  do
    end
  end

  context 'e faz login como cliente' do

    it 'e não vê links de edição para os buffets' do
      # Arrange
      user_client= UserClient.create!(name: '9s', cpf: '09308686339',email: '9s@bot.com', password: 'senha123' )

      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      buffet_0= Buffet.create!( brand_name: 'Buffet FFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '97990518000151',
                      contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                      district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                      description: 'Buffet para festas fantasticas', playment_methods: 'PIX', user_owner: user_owner_0 )
      user_owner_1 = UserOwner.create!(email: 'cc@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Buffet da C.C.', corporate_name: 'Buffet Zero' ,cnpj: '44715046000162',
                      contact_phone: '88969721936', contact_email: 'buffetcc@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'AM', city: 'Manaus', cep: '4522-9968',
                      description: 'Buffet para festas unicas', playment_methods: 'PIX', user_owner: user_owner_1 )

      Event.create!(name:'Festa da B2' ,description:'Festa de androids', min_guests:'1', max_guests:'10',
                    duration: '120', menu: 'Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'false', buffet_id: buffet_0.id)
      Event.create!(name:'Festa do ZERO' ,description:'Festa de Elevens', min_guests:'10', max_guests:'100',
                    duration: '240', menu: 'Muita Comida',decoration:  'true', alcoholic_beverages: 'true', parking_servise: 'true',
                    event_location:'true', buffet_id: buffet_0.id)
      # Act
      login_as(user_client, scope: :user_client)
      visit root_path
      click_on 'Buffet Fantasticos'
      # Assert
      expect(page).to have_content 'Buffet FFs'
      expect(page).not_to have_content 'Editar Buffet'
      expect(page).not_to have_content 'Novo Evento'
      expect(page).to have_content 'Festa da B2'
      expect(page).to have_content 'Festa do ZERO'

    end
    it  'e faz sua inscrição usando um CPF único e válido.' do
      # Arrange
      user_client= UserClient.create!(name: '9s', cpf: '09308686339',email: '9s@bot.com', password: 'senha123' )

      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Buffet FFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '97990518000151',
                      contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                      district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                      description: 'Buffet para festas fantasticas', playment_methods: 'PIX', user_owner: user_owner_0 )
      user_owner_1 = UserOwner.create!(email: 'cc@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Buffet da C.C.', corporate_name: 'Buffet Zero' ,cnpj: '44715046000162',
                      contact_phone: '88969721936', contact_email: 'buffetcc@gmail.com',  address: 'Rua dos dois',
                      district: 'Bairro fantasia', state: 'AM', city: 'Manaus', cep: '4522-9968',
                      description: 'Buffet para festas unicas', playment_methods: 'PIX', user_owner: user_owner_1 )

      # Act
      login_as(user_client, scope: :user_client)
      visit root_path
      # Assert
      within('nav') do
        expect(page).to have_content '9s'
      end

    end

    it 'e vê seu nome no canto superior da tela'  do
    end

  end

end
