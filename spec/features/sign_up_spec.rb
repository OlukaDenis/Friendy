require 'rails_helper'

RSpec.feature 'SignUp user', type: :feature do
  scenario 'with valid credentials' do
    visit new_user_registration_path
    user = build(:user)
    sign_up(user)
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  def sign_up(user)
    fill_in 'Email', with: user.email
    fill_in 'Name', with: user.name
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Sign up'
  end
end
