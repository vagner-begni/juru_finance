require 'rails_helper'

describe 'Admin deletes a user...' do
  it 'successfully if there are others admins' do
    admin = User.create!(email: 'morador001@email.com', password: 'morador001', role: 'admin')
    user = User.create!(email: 'morador002@email.com', password: 'morador002', role: 'admin')

    login_as admin
    visit root_path
    within('nav') do
      click_on 'Administrador'
    end
    within("tr#user_#{user.id}") do
      click_on 'Excluir'
    end

    expect(page).to have_content('Usuário excluído com sucesso.')
    expect(page).not_to have_content(user.email)
  end

  it 'and get error if its the only Admin' do
    admin_a = User.create!(email: 'morador001@email.com', password: 'morador001', role: 'admin')

    login_as admin_a
    visit root_path
    within('nav') do
      click_on 'Administrador'
    end
    within("tr#user_#{admin_a.id}") do
      click_on 'Excluir'
    end

    expect(page).to have_content('Falha na Exclusão! Sistema não pode ficar sem administrador.')
    within("tr#user_#{admin_a.id}") do
      expect(page).to have_content('Administrador')
      expect(page).not_to have_button('Administrador')
      expect(page).to have_button('Financeiro')
      expect(page).to have_button('Funcionário')
      expect(page).to have_button('Morador')
    end
  end
end
