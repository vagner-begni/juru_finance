require 'rails_helper'

describe 'User authenticate yourself' do
  it 'successfully' do
    User.create!(email: 'morador001@email.com', password: 'morador001')

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'morador001@email.com'
      fill_in 'Senha', with: 'morador001'
      click_on 'Entrar'
    end

    expect(page).to have_content('Login efetuado com sucesso.')
    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'morador001@email.com'
    end
  end

  it 'and logout yourself' do
    User.create!(email: 'morador001@email.com', password: 'morador001')

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'morador001@email.com'
      fill_in 'Senha', with: 'morador001'
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(page).to have_content('Logout efetuado com sucesso.')
    within('nav') do
      expect(page).to have_link 'Entrar'
      expect(page).not_to have_button 'Sair'
      expect(page).not_to have_content 'morador001@email.com'
    end
  end
end
