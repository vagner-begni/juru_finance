require 'rails_helper'

describe 'Admin deletes a user...' do
  it 'successfully if there are others admins' do
    admin_a = User.create!(email: 'morador001@email.com', password: 'morador001', role: 'admin')
    admin_b = User.create!(email: 'morador002@email.com', password: 'morador002', role: 'admin')

    login_as admin_a
    visit root_path
    within('nav') do
      click_on 'Administrador'
    end
    within("tr#user_#{admin_b.id}") do
      click_on 'Excluir'
    end

    expect(page).to have_content('Usuário excluído com sucesso.')
    expect(page).not_to have_content(admin_b.email)
  end

  it 'and dont see delete button in the actions of your line' do
    admin = User.create!(email: 'morador001@email.com', password: 'morador001', role: 'admin')
    User.create!(email: 'morador002@email.com', password: 'morador002', role: 'admin')

    login_as admin
    visit root_path
    within('nav') do
      click_on 'Administrador'
    end

    within("tr#user_#{admin.id}") do
      expect(page).not_to have_button('Excluir')
    end
  end
end
