require 'rails_helper'

describe 'Not Admin visits users page' do
  it 'a non authorized user dont see the link' do
    visit root_path

    expect(page).not_to have_link('Administrador')
  end

  it 'a authorized user without role dont see the link' do
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
