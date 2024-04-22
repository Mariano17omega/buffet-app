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
      UserOwner.create(email: 'mariano@gmail.com', password: 'password' )
      # Act
      visit root_path
      click_on 'Sou Dono de Buffet'


      fill_in 'E-mail', with: 'mariano@gmail.com'
      fill_in 'Senha', with: 'password'
      click_button 'Entrar'
      click_button 'Sair'
      # Assert
      expect(page).to have_content('Até breve!')
    end
  end
end
