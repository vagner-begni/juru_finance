require 'rails_helper'

describe 'Admin setting a undefined role...' do
  it 'see the roles buttons' do
    admin = User.create!(email: 'morador001@email.com', password: 'morador001', role: 'admin')
    user = User.create!(email: 'morador002@email.com', password: 'morador002')

    login_as admin
    visit root_path
    within('nav') do
      click_on 'Administrador'
    end

    within("tr#user_#{user.id}") do
      expect(page).to have_button('Financeiro')
      expect(page).to have_button('Administrador')
      expect(page).to have_button('Funcionário')
      expect(page).to have_button('Morador')
    end
  end

  it 'to administrator' do
    admin = User.create!(email: 'morador001@email.com', password: 'morador001', role: 'admin')
    user = User.create!(email: 'morador002@email.com', password: 'morador002')

    login_as admin
    visit root_path
    within('nav') do
      click_on 'Administrador'
    end
    within("tr#user_#{user.id}") do
      click_on 'Administrador'
    end

    expect(page).to have_content('Perfil atualizado com sucesso.')
    within("tr#user_#{user.id}") do
      expect(page).to have_content('Administrador')
      expect(page).not_to have_button('Administrador')
      expect(page).to have_button('Financeiro')
      expect(page).to have_button('Funcionário')
      expect(page).to have_button('Morador')
    end
  end

  it 'to financial' do
    admin = User.create!(email: 'morador001@email.com', password: 'morador001', role: 'admin')
    user = User.create!(email: 'morador002@email.com', password: 'morador002')

    login_as admin
    visit root_path
    within('nav') do
      click_on 'Administrador'
    end
    within("tr#user_#{user.id}") do
      click_on 'Financeiro'
    end

    expect(page).to have_content('Perfil atualizado com sucesso.')
    within("tr#user_#{user.id}") do
      expect(page).to have_content('Financeiro')
      expect(page).not_to have_button('Financeiro')
      expect(page).to have_button('Administrador')
      expect(page).to have_button('Funcionário')
      expect(page).to have_button('Morador')
    end
  end

  it 'to employee' do
    admin = User.create!(email: 'morador001@email.com', password: 'morador001', role: 'admin')
    user = User.create!(email: 'morador002@email.com', password: 'morador002')

    login_as admin
    visit root_path
    within('nav') do
      click_on 'Administrador'
    end
    within("tr#user_#{user.id}") do
      click_on 'Funcionário'
    end

    expect(page).to have_content('Perfil atualizado com sucesso.')
    within("tr#user_#{user.id}") do
      expect(page).to have_content('Funcionário')
      expect(page).not_to have_button('Funcionário')
      expect(page).to have_button('Administrador')
      expect(page).to have_button('Financeiro')
      expect(page).to have_button('Morador')
    end
  end

  it 'to resident' do
    admin = User.create!(email: 'morador001@email.com', password: 'morador001', role: 'admin')
    user = User.create!(email: 'morador002@email.com', password: 'morador002')

    login_as admin
    visit root_path
    within('nav') do
      click_on 'Administrador'
    end
    within("tr#user_#{user.id}") do
      click_on 'Morador'
    end

    expect(page).to have_content('Perfil atualizado com sucesso.')
    within("tr#user_#{user.id}") do
      expect(page).to have_content('Morador')
      expect(page).not_to have_button('Morador')
      expect(page).to have_button('Administrador')
      expect(page).to have_button('Financeiro')
      expect(page).to have_button('Funcionário')
    end
  end
end

describe 'Admin try to change your own role...' do
  it 'and doesnt see change role buttons' do
    admin_a = User.create!(email: 'morador001@email.com', password: 'morador001', role: 'admin')
    User.create!(email: 'morador002@email.com', password: 'morador002', role: 'admin')

    login_as admin_a
    visit root_path
    within('nav') do
      click_on 'Administrador'
    end

    within("tr#user_#{admin_a.id}") do
      expect(page).to have_content('Administrador')
      expect(page).not_to have_button('Administrador')
      expect(page).not_to have_button('Financeiro')
      expect(page).not_to have_button('Funcionário')
      expect(page).not_to have_button('Morador')
    end
  end
end
