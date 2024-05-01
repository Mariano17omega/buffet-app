require 'rails_helper'

describe 'Usuario visita tela inicial' do
  context 'como dono de buffet' do
    it 'e vê as opções de inscrição de usuários' do
      # Arrange
      # Act
      visit root_path
      click_on 'Inscrição'
      # Assert
      expect(page).to have_content 'Sou Dono de Buffet'
      expect(page).to have_content 'Sou Cliente'
    end

    it 'e vê a página de inscrição para um dono de bufê' do
      # Arrange
      # Act
      visit root_path
      click_on 'Inscrição'
      click_on 'Sou Dono de Buffet'

      # Assert
      expect(page).to have_current_path(new_user_owner_registration_path)
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
      expect(page).to have_field 'Confirmar senha'
    end

    it 'e faz a inscrição com sucesso como um dono de bufê' do
      # Arrange
      # Act
      visit root_path
      click_on 'Inscrição'
      click_on 'Sou Dono de Buffet'


      fill_in 'E-mail', with: 'dono_de_bufe@ex.com'
      fill_in 'Senha', with: 'mypassword'
      fill_in 'Confirmar senha', with: 'mypassword'

      click_button 'Inscrever-se'


      # Assert
      expect(page).to have_content('Bem vindo! Você se registrou com sucesso.')
    end


    it 'e faz a Inscrição e depois o logout' do
      # Arrange
      # Act
      visit root_path
      click_on 'Inscrição'
      click_on 'Sou Dono de Buffet'


      fill_in 'E-mail', with: 'dono_de_bufe@ex.com'
      fill_in 'Senha', with: 'mypassword'
      fill_in 'Confirmar senha', with: 'mypassword'

      click_button 'Inscrever-se'


      # Assert
      click_button 'Sair'
      # Assert
      expect(page).to have_content('Até breve!')
    end

  end
end
