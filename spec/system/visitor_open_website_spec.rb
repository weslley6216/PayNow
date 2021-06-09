require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'successfully' do

    visit root_path

    expect(page).to have_css('h1', text: 'PayNow')
    expect(page).to have_css('h3', text: 'Simplifique o recebimento de cobranças '\
                                          'e automatize seu negócio')
    expect(page).to have_link('Cadastre-se')
    expect(page).to have_link('Entrar')

  end
end