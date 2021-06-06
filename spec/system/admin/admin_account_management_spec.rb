require 'rails_helper'

describe 'Admin account management' do
  context 'log in' do
    it 'successfuly' do
      Admin.create!(email: 'admin@paynow.com', password: '123456')

      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: 'admin@paynow.com'
      fill_in 'Senha', with: '123456'
      within 'form' do
        click_on 'Entrar'
      end

      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('Olá, admin@paynow.com')
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link('Entrar')
      expect(page).to have_link('Sair')
    end

    it 'cannot have a blank fields' do
      Admin.create!(email: 'admin@paynow.com', password: '123456')
      
      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: ''
      fill_in 'Senha', with: ''
      within 'form' do
        click_on 'Entrar'
      end
    end

  end

  context 'logout' do
    it 'successfully' do
      admin = Admin.create!(email: 'admin@paynow.com', password: '123456')

      login_as admin, scope: :admin
      visit root_path
      click_on 'Sair'

      expect(page).to have_text('Saiu com sucesso')
      expect(page).to_not have_text('Olá, admin@paynow.com')
      expect(current_path).to eq(root_path)
      expect(page).to have_link('Entrar')
      expect(page).to_not have_link('Sair')
    end
  end

  context 'Admin forgot password' do
    it 'receive reset email successfully' do
      Admin.create!(email: 'admin@user.com', password: '123456')

      visit root_path
      click_on 'Entrar'
      click_on 'Esqueceu sua senha?'
      fill_in 'Email', with: 'admin@paynow.com'
      click_on 'Envie-me instruções de redefinição de senha'

      expect(current_path).to eq(new_admin_session_path)
      expect(page).to have_text('você receberá um e-mail com instruções para a troca da sua senha')
    end

    it 'and change password' do
      admin = Admin.create!(email: 'user@user.com', password: '123456')
      token = admin.send_reset_password_instructions

      visit edit_user_password_path(reset_password_token: token)
      fill_in 'Nova Senha', with: '12345678'
      fill_in 'Confirmar Nova Senha', with: '12345678'
      click_on 'Mudar Minha Senha'
      expect(page).to have_content('Sua senha foi alterada com sucesso')
      expect(current_path).to eq(root_path)

    end
  end
end