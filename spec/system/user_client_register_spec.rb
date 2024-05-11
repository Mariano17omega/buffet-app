require 'rails_helper'

describe 'Usuario visita tela inicial' do
  context 'como visitante' do
    it 'e vê a página de inscrição para um Cliente'  do
      # Arrange
      # Act
      visit root_path
      click_on 'Inscrição'
      click_on 'Sou Cliente'
      # Assert
      expect(page).to have_current_path(new_user_client_registration_path)
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
      expect(page).to have_field 'Confirmar senha'
    end


    it 'e faz a inscrição com sucesso como um Cliente' do
      # Arrange
      # Act
      visit root_path
      click_on 'Inscrição'
      click_on 'Sou Cliente'

      fill_in 'E-mail', with: 'cliente@ex.com'
      fill_in 'Senha', with: 'mypassword'
      fill_in 'Confirmar senha', with: 'mypassword'

      click_button 'Inscrever-se'


      # Assert
      expect(page).to have_content('Bem vindo! Você se registrou com sucesso')
    end

    it 'e após fazer a inscrição, o Cliente faz o cadastro do perfil com sucesso' do
      # Arrange
      # Act
      visit root_path
      click_on 'Inscrição'
      click_on 'Sou Cliente'

      fill_in 'E-mail', with: 'cliente@ex.com'
      fill_in 'Senha', with: 'mypassword'
      fill_in 'Confirmar senha', with: 'mypassword'
      click_button 'Inscrever-se'

      fill_in 'Nome', with: 'cliente_M'
      fill_in 'CPF', with: '36936186076'
      click_button 'Cadastrar'

      # Assert
      expect(page).to have_content 'Perfil criado com sucesso!'
      expect(page).to have_content 'cliente_M'
      expect(page).to have_content 'Bem-vindo ao Cadê Buffet?'

    end

    it 'e após fazer a inscrição, o Cliente faz o cadastro do perfil com Nome e CPF invalidos' do

      # Arrange
      # Act
      visit root_path
      click_on 'Inscrição'
      click_on 'Sou Cliente'

      fill_in 'E-mail', with: 'cliente@ex.com'
      fill_in 'Senha', with: 'mypassword'
      fill_in 'Confirmar senha', with: 'mypassword'
      click_button 'Inscrever-se'

      fill_in 'Nome', with: ''
      fill_in 'CPF', with: '3693616076'
      click_button 'Cadastrar'

      # Assert
      expect(page).to have_content 'Cadastro de Perfil'
      expect(page).to have_content 'CPF não é válido'
      expect(page).to have_content 'Nome não pode ficar em branco'
    end

  end

  context 'e faz login como cliente' do

    it 'e depois sai' do
      # Arrange
      client = UserClient.create!(email: 'clientex@example.com', password: 'mypassword' )
      Profile.create!(name: 'ClienteX', cpf: '19626041013' , user_client: client)

      # Act
      visit root_path
      click_on 'Entrar'
      click_on 'Sou Cliente'
      fill_in 'E-mail', with: 'clientex@example.com'
      fill_in 'Senha', with: 'mypassword'
      click_button 'Entrar'

      # Assert
      expect(page).to have_content 'ClienteX'
      expect(page).to have_content 'Bem-vindo ao Cadê Buffet?'

    end
    it 'sem ter um perfil cadastrado e vê o formulario do perfil' do
      # Arrange
      UserClient.create!(email: 'clientex@example.com', password: 'mypassword' )

      # Act
      visit root_path
      click_on 'Entrar'
      click_on 'Sou Cliente'
      fill_in 'E-mail', with: 'clientex@example.com'
      fill_in 'Senha', with: 'mypassword'
      click_button 'Entrar'

      # Assert
      expect(page).to have_content 'Cadastro de Perfil'
      expect(page).to have_field 'Nome'
      expect(page).to have_field 'CPF'

    end

    it 'e não vê links para edição para de buffet e de criação de eventos' do
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

      # Assert
      expect(page).not_to have_content 'Editar Buffet'
      expect(page).not_to have_content 'Novo Evento'

    end


    it 'e não vê links para edição para de buffet e de criação de eventos' do
      # Arrange
      client = UserClient.create!(email: 'clientex@example.com', password: 'mypassword' )
      Profile.create!(name: 'ClienteX', cpf: '19626041013' , user_client: client)


      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      buffet_0 =Buffet.create!( brand_name: 'Buffet FFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '97990518000151',
                                contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                                district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                                description: 'Buffet para festas fantasticas', user_owner: user_owner_0 , payment_method_attributes:
                                { cash: 'true', credit_card: 'true', debit_card: 'false', bank_transfer: 'true', paypal: 'false',
                                check: 'true', pix: 'true', bitcoin: 'true', google_pay: 'false' } )
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
      expect(page).not_to have_content 'Editar Evento'
      expect(page).to have_content  'Voltar'

    end

  end
end
