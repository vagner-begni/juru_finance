require 'rails_helper'

describe 'Not Admin visits users page' do
  it 'a non authorized user dont see the link' do
    visit root_path

    expect(page).not_to have_link('Administrador')
  end

  it 'a authorized user wihout role dont see the link' do
    user = User.create!(email: 'morador001@email.com', password: 'morador001')

    login_as user
    visit root_path

    expect(page).not_to have_link('Administrador')
  end

  it 'a authorized financial dont see the link' do
    user = User.create!(email: 'morador001@email.com', password: 'morador001', role: 'financial')

    login_as user
    visit root_path

    expect(page).not_to have_link('Administrador')
  end

  it 'a authorized employee dont see the link' do
    user = User.create!(email: 'morador001@email.com', password: 'morador001', role: 'employee')

    login_as user
    visit root_path

    expect(page).not_to have_link('Administrador')
  end

  it 'a authorized resident dont see the link' do
    user = User.create!(email: 'morador001@email.com', password: 'morador001', role: 'resident')

    login_as user
    visit root_path

    expect(page).not_to have_link('Administrador')
  end
end

describe 'Authenticated Admin visits users page' do
  it 'successfully' do
    admin = User.create!(email: 'morador001@email.com', password: 'morador001', role: 'admin')

    login_as admin
    visit root_path
    within('nav') do
      click_on 'Administrador'
    end

    expect(page).to have_content('Usuários Cadastrados')
  end
end

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

describe 'Admin sets a Admin to other role...' do
  it 'successfully if there are others admins' do
    admin_a = User.create!(email: 'morador001@email.com', password: 'morador001', role: 'admin')
    User.create!(email: 'morador002@email.com', password: 'morador002', role: 'admin')

    login_as admin_a
    visit root_path
    within('nav') do
      click_on 'Administrador'
    end
    within("tr#user_#{admin_a.id}") do
      click_on 'Financeiro'
    end

    expect(page).to have_content('Perfil atualizado com sucesso.')
    within("tr#user_#{admin_a.id}") do
      expect(page).to have_content('Financeiro')
      expect(page).not_to have_button('Financeiro')
      expect(page).to have_button('Administrador')
      expect(page).to have_button('Funcionário')
      expect(page).to have_button('Morador')
    end
  end

  it 'and get error if theres only one Admin' do
    admin_a = User.create!(email: 'morador001@email.com', password: 'morador001', role: 'admin')

    login_as admin_a
    visit root_path
    within('nav') do
      click_on 'Administrador'
    end
    within("tr#user_#{admin_a.id}") do
      click_on 'Financeiro'
    end

    expect(page).to have_content('Sistema não pode ficar sem administrador!')
    within("tr#user_#{admin_a.id}") do
      expect(page).to have_content('Administrador')
      expect(page).not_to have_button('Administrador')
      expect(page).to have_button('Financeiro')
      expect(page).to have_button('Funcionário')
      expect(page).to have_button('Morador')
    end
  end
end
