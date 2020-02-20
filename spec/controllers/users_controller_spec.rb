require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    before(:each) do
        @user = create(:user)
        @user2 = create(:user, email: "test@me.com", password: "testing", name: "Test User")
    end


end
