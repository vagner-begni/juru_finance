require 'rails_helper'

describe 'Admin visits users page' do
  it 'successfully' do
    admin = User.create!(email: 'morador001@email.com', password: 'morador001', role: 'admin')

    login_as admin
    visit root_path
    within('nav') do
      click_on 'Usuários'
    end

    expect(page).to have_content('Usuários Cadastrados')
  end
end