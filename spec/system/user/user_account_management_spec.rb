require 'rails_helper'

describe 'User account management' do
  context 'registration' do
    it 'with email and password' do
      
      visit root_path
      click_on 'Cadastre-se'
      
      fill_in 'Email', with: 'user@codeplay.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '123456'
      click_on 'Criar conta'
      
      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('Olá, user@codeplay.com.br')
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link('Registre-se')
      expect(page).to have_link('Sair')
    end

    it 'without valid field' do
      visit new_user_registration_path
      click_on 'Cadastre-se'
      fill_in 'Email', with: ''
      fill_in 'Senha', with: ''
      fill_in 'Confirmação de Senha', with: ''
      click_on 'Criar conta'

      expect(page).to have_text('Cadastro de Usuário')
      expect(page).to have_text('não pode ficar em branco', count: 2)

    end

    it 'password not match confirmation' do
      visit new_user_registration_path
      click_on 'Cadastre-se'
      fill_in 'Email', with: 'user@codeplay.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '654321'
      click_on 'Criar conta'

      expect(page).to have_text('não é igual a Senha')
    end

    it 'with email not unique' do
      User.create!(email: 'user@codeplay.com.br', password: '123456')

      visit new_user_registration_path
      click_on 'Cadastre-se'
      fill_in 'Email', with: 'user@codeplay.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '123456'
      click_on 'Criar conta'

      expect(page).to have_text('já está em uso')
    end
  end

  context 'sign in' do
    it 'with email and password' do
      User.create!(email: 'user@codeplay.com.br', password: '123456')
      
      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: 'user@codeplay.com.br'
      fill_in 'Senha', with: '123456'
      within 'div#login' do
        click_on 'Entrar'
      end

      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('user@codeplay.com.br')
      expect(page).to have_link('Cadastre Sua Empresa')
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link('Cadastre-se')
      expect(page).to_not have_link('Entrar')
      expect(page).to have_link('Sair')
    end

    it 'without valid field' do
      User.create!(email: 'user@codeplay.com.br', password: '123456')

      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: ''
      fill_in 'Senha', with: ''
      within 'div#login' do
        click_on 'Entrar'
      end

      expect(page).to have_text('Email ou senha inválida')
    end
   end

  context 'logout' do
    it 'successfully' do

      login_user
      visit root_path
      click_on 'Sair'

      expect(page).to have_text('Saiu com sucesso')
      expect(page).to_not have_text('user@user.com')
      expect(current_path).to eq(root_path)
      expect(page).to have_link('Cadastre-se')
      expect(page).to have_link('Entrar')
      expect(page).to_not have_link('Sair')
    end
  end

  context 'user forgot password' do
    it 'receive reset email successfully' do
      User.create!(email: 'user@codeplay.com.br', password: '123456')

      visit root_path
      click_on 'Entrar'
      click_on 'Esqueceu sua senha?'
      fill_in 'Email', with: 'user@codeplay.com.br'
      click_on 'Envie-me instruções de redefinição de senha'

      expect(current_path).to eq(new_user_session_path)
      expect(page).to have_text('você receberá um e-mail com instruções para a troca da sua senha')
    end

    it 'and change password' do
      user = User.create!(email: 'user@codeplay.com.br', password: '123456')
      token = user.send_reset_password_instructions

      visit edit_user_password_path(reset_password_token: token)
      fill_in 'Nova Senha', with: '12345678'
      fill_in 'Confirmar Nova Senha', with: '12345678'
      click_on 'Mudar Minha Senha'
      expect(page).to have_content('Sua senha foi alterada com sucesso')
      expect(current_path).to eq(root_path)

    end
  end
end
