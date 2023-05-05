require 'rails_helper'

describe 'User creates your account' do
  it 'successfully' do
    visit root_path
    click_on 'Entrar'
    click_on 'Inscrever-se'
    within('form') do
      fill_in 'E-mail', with: 'morador001@email.com'
      fill_in 'Senha', with: 'morador001'
      fill_in 'Confirme sua senha', with: 'morador001'
      click_on 'Inscrever-se'
    end

    expect(page).to have_content('morador001@email.com')
    expect(page).to have_button('Sair')
  end
end
