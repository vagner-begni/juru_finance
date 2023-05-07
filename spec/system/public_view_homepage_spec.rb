require 'rails_helper'

describe 'Public visits homepage' do
  it "and see the app's name" do
    visit('/')
    expect(page).to have_content('Condomínio - Controle Financeiro')
  end
end
