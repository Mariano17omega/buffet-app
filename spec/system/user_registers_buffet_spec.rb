require 'rails_helper'

describe 'Usuario visita tela inicial' do
  context 'como dono de buffet' do
    it 'e faz a inscrição e depois vê o cadastro de bufet' do
      # Arrange
      # Act
      visit root_path
      click_on 'Entrar'
      click_on 'Sou Dono de Buffet'
      click_on 'Inscrever-se'

      fill_in 'E-mail', with: 'dono_de_bufe@gmail.com'
      fill_in 'Senha', with: 'mypassword'
      fill_in 'Confirmar senha', with: 'mypassword'
      click_button 'Inscrever-se'

      # Assert
      expect(page).to have_content 'Bem vindo! Você se registrou com sucesso.'
      expect(page).to have_content 'Nome fantasia'
      expect(page).to have_content 'Razão social'
      expect(page).to have_content 'CNPJ'
      expect(page).to have_content 'Telefone para contato'
      expect(page).to have_content 'E-mail para contato'
      expect(page).to have_content 'Endereço'
      expect(page).to have_content 'Bairro'

      expect(page).to have_content 'Estado'
      expect(page).to have_content 'Cidade'
      expect(page).to have_content 'CEP'
      expect(page).to have_content 'Descrição'
      expect(page).to have_content 'Meios de pagamentos aceitos'
      expect(page).to have_button 'Cadastrar Buffet'

    end

    it 'e faz inscrição e depois faz o cadastro de bufet com sucesso' do
      # Arrange
      # Act
      visit root_path
      click_on 'Entrar'
      click_on 'Sou Dono de Buffet'
      click_on 'Inscrever-se'

      fill_in 'E-mail', with: 'dono_de_bufe@gmail.com'
      fill_in 'Senha', with: 'mypassword'
      fill_in 'Confirmar senha', with: 'mypassword'
      click_button 'Inscrever-se'

      fill_in 'Nome fantasia', with: 'Buffet Perfeito'
      fill_in 'Razão social', with: 'Buffet LTDA'
      fill_in 'CNPJ', with: '97990518000151'
      fill_in 'Telefone para contato', with: '11968243458'
      fill_in 'E-mail para contato', with: 'buffet@gmail.com'
      fill_in 'Endereço', with: 'Rua dos Buffets'
      fill_in 'Bairro', with: 'Bairro do Buffet'
      fill_in 'Estado', with: 'AM'
      fill_in 'Cidade', with: 'Manaus'
      fill_in 'CEP', with: '2335-3434'
      fill_in 'Descrição', with: 'Buffet para festas perfeitas'
      fill_in 'Meios de pagamentos aceitos', with: 'PIX'

      click_on 'Cadastrar Buffet'
      # Assert
      expect(page).to have_content 'Buffet cadastrado com sucesso.'

    end

    it 'e faz a inscrição e depois faz o cadastro de bufet faltando dados' do
      # Arrange
      # Act
      visit root_path
      click_on 'Entrar'
      click_on 'Sou Dono de Buffet'
      click_on 'Inscrever-se'

      fill_in 'E-mail', with: 'dono_de_bufe@gmail.com'
      fill_in 'Senha', with: 'mypassword'
      fill_in 'Confirmar senha', with: 'mypassword'
      click_button 'Inscrever-se'

      fill_in 'Nome fantasia', with: ''
      fill_in 'Razão social', with: 'Buffet LTDA'
      fill_in 'Telefone para contato', with: ''
      fill_in 'E-mail para contato', with: ''
      fill_in 'Endereço', with: 'Rua dos Buffets'
      fill_in 'Bairro', with: 'Bairro do Buffet'
      fill_in 'Estado', with: 'AM'
      fill_in 'Cidade', with: 'Manaus'
      fill_in 'CEP', with: '2335-3434'
      fill_in 'Descrição', with: 'Buffet para festas perfeitas'
      fill_in 'Meios de pagamentos aceitos', with: 'PIX'

      click_on 'Cadastrar Buffet'
      # Assert
      expect(page).to have_content 'Buffet não cadastrado.'
      expect(page).to have_content 'Nome fantasia não pode ficar em branco'
      expect(page).to have_content 'Telefone para contato não pode ficar em branco'
    end

    it 'e faz o login com sucesso' do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Buffet FFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '97990518000151',
                      contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                      district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                      description: 'Buffet para festas fantasticas', playment_methods: 'PIX', user_owner: user_owner_0 )


      # Act
      visit root_path
      click_on 'Entrar'
      click_on 'Sou Dono de Buffet'

      fill_in 'E-mail', with: 'proprietario@example.com'
      fill_in 'Senha', with: 'senha123'
      click_button 'Entrar'
      # Assert
      expect(page).to have_content 'Buffet Fantasticos'
    end

    it 'e faz o login sem cadastra o bufet e depois faz o login novamente e vê a tela de cadastro' do
      # Arrange
      UserOwner.create!(email: 'proprietario0@example.com', password: 'senha123' )

      # Act
      visit root_path
      click_on 'Entrar'
      click_on 'Sou Dono de Buffet'

      fill_in 'E-mail', with: 'proprietario0@example.com'
      fill_in 'Senha', with: 'senha123'
      click_button 'Entrar'
      # Assert
      expect(page).to have_content 'Nome fantasia'
      expect(page).to have_content 'Razão social'
      expect(page).to have_content 'CNPJ'
      expect(page).to have_content 'Telefone para contato'
      expect(page).to have_content 'E-mail para contato'
      expect(page).to have_content 'Endereço'
      expect(page).to have_content 'Bairro'

      expect(page).to have_content 'Estado'
      expect(page).to have_content 'Cidade'
      expect(page).to have_content 'CEP'
      expect(page).to have_content 'Descrição'
      expect(page).to have_content 'Meios de pagamentos aceitos'
      expect(page).to have_button 'Cadastrar Buffet'
    end


    it 'e faz o login e editar seu buffet' do
      # Arrange
      user_owner_0 = UserOwner.create!(email: 'proprietario@example.com', password: 'senha123' )
      Buffet.create!( brand_name: 'Buffet FFs', corporate_name: 'Buffet Fantasticos' ,cnpj: '97990518000151',
                      contact_phone: '55972662205', contact_email: 'buffetfantastico@gmail.com',  address: 'Rua dos Buffets',
                      district: 'Bairro do Buffet Bonito', state: 'AM', city: 'Manaus', cep: '2335-3434',
                      description: 'Buffet para festas fantasticas', playment_methods: 'PIX', user_owner: user_owner_0 )


      # Act
      visit root_path
      click_on 'Entrar'
      click_on 'Sou Dono de Buffet'

      fill_in 'E-mail', with: 'proprietario@example.com'
      fill_in 'Senha', with: 'senha123'
      click_button 'Entrar'
      click_on 'Editar Buffet'
      # Assert
      expect(page).to have_content 'Editar Buffet'
      expect(page).to have_content 'Nome fantasia'
      expect(page).to have_content 'Razão social'
      expect(page).to have_content 'CNPJ'
    end

    it 'e faz o login e editar outro buffet' do
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
      click_on 'Entrar'
      click_on 'Sou Dono de Buffet'

      fill_in 'E-mail', with: 'proprietario@example.com'
      fill_in 'Senha', with: 'senha123'
      click_button 'Entrar'
      visit root_path
      click_on 'Buffet Zero'

      # Assert
      expect(page).to have_content 'Buffet da C.C.'
      expect(page).to have_content 'Buffet Zero'
      expect(page).not_to have_content 'Editar Buffet'
    end
  end
end
