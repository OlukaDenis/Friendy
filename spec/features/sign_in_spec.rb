require 'rails_helper'

RSpec.feature 'User signin', type: :feature do
  scenario 'sign in user with correct user details' do
    visit new_user_session_path
    user = create(:user, email: 'denis@gmail.com', password: '1234567')
    signin(user)
    expect(page).to have_content('Signed in successfully.')
  end

  def signin(user)
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end
