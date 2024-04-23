require 'rails_helper'

describe 'Usuario visita tela inicial de inscrição' do
  context 'como dono de buffet' do
    it 'e vê as opções de cadastro de usuários' do
      # Arrange
      # Act
      visit root_path

      # Assert
      expect(page).to have_content 'Sou Dono de Buffet'
      expect(page).to have_content 'Sou Cliente'
    end

    it 'e vê a página de cadastro para um dono de bufê' do
      # Arrange
      # Act
      visit root_path
      click_on 'Sou Dono de Buffet'
      click_on 'Inscrever-se'

      # Assert
      expect(page).to have_current_path(new_user_owner_registration_path)
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
      expect(page).to have_field 'Confirmar senha'
    end

    it 'e faz o cadastro com sucesso como um dono de bufê' do
      # Arrange
      # Act
      visit root_path
      click_on 'Sou Dono de Buffet'
      click_on 'Inscrever-se'

      fill_in 'E-mail', with: 'dono_de_bufe@ex.com'
      fill_in 'Senha', with: 'mypassword'
      fill_in 'Confirmar senha', with: 'mypassword'
      click_button 'Inscrever-se'

      # Assert
      expect(page).to have_content('Bem vindo! Você se registrou com sucesso.')
    end


    it 'e faz o login e depois o logout' do
      # Arrange
      # Act
      visit root_path
      click_on 'Sou Dono de Buffet'
      click_on 'Inscrever-se'

      fill_in 'E-mail', with: 'dono_de_bufe@ex.com'
      fill_in 'Senha', with: 'mypassword'
      fill_in 'Confirmar senha', with: 'mypassword'
      click_button 'Inscrever-se'

      # Assert
      click_button 'Sair'
      # Assert
      expect(page).to have_content('Até breve!')
    end

    it 'e faz o login e depois vê o cadastro de bufet' do
      # Arrange
      # Act
      visit root_path
      click_on 'Sou Dono de Buffet'
      click_on 'Inscrever-se'

      fill_in 'E-mail', with: 'dono_de_bufe@gmailxom.com'
      fill_in 'Senha', with: 'mypassword'
      fill_in 'Confirmar senha', with: 'mypassword'
      click_button 'Inscrever-se'

      # Assert
      expect(page).to have_content('Bem vindo! Você se registrou com sucesso.')
      expect(page).to have_content('Nome fantasia')
      expect(page).to have_content('Razão social')
      expect(page).to have_content('CNPJ')
      expect(page).to have_content('Telefone para contato')
      expect(page).to have_content('E-mail para contato')
      expect(page).to have_content('Endereço')
      expect(page).to have_content('Bairro')

      expect(page).to have_content('Estado')
      expect(page).to have_content('Cidade')
      expect(page).to have_content('CEP')
      expect(page).to have_content('Descrição')
      expect(page).to have_content('Meios de pagamentos aceitos')
      expect(page).to have_button('Cadastrar Buffet')

    end

    it 'e faz o login e depois faz o cadastro de bufet' do
      # Arrange
      # Act
      visit root_path
      click_on 'Sou Dono de Buffet'
      click_on 'Inscrever-se'

      fill_in 'E-mail', with: 'dono_de_bufe@gmailxom.com'
      fill_in 'Senha', with: 'mypassword'
      fill_in 'Confirmar senha', with: 'mypassword'
      click_button 'Inscrever-se'

      # Assert
      fill_in 'Nome fantasia', with: 'Buffet Perfeito'
      fill_in 'Razão social', with: 'Buffet LTDA'
      fill_in 'Telefone para contato', with: '34343434'
      fill_in 'E-mail para contato', with: ''
      fill_in 'Endereço', with: 'Rua dos Buffets'
      fill_in 'Bairro', with: 'Bairro do Buffet'
      fill_in 'Estado', with: 'AM'
      fill_in 'Cidade', with: 'Manaus'
      fill_in 'CEP', with: '2335-3434'
      fill_in 'Descrição', with: 'Buffet para festas perfeitas'
      fill_in 'Meios de pagamentos aceitos', with: 'PIX'

      click_on 'Cadastrar Buffet'
    end

  end
end
