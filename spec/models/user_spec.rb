require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = create(:user)
  end

  it 'has valid attributes' do
    expect(@user).to be_valid
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:name) }

    # Allow valid emails
    it do
      should_not allow_values('foo@gmail,com', 'foobar.com').for(:email)
      should allow_values('foo@gmail.com', 'foor.bar@me.com').for(:email)
    end

    # Not to allow nil values
    it do
      expect(@user).not_to allow_value(nil).for(:name)
      expect(@user).not_to allow_value(nil).for(:email)
      expect(@user).not_to allow_value(nil).for(:password)
    end

    # Password length
    it do
      should validate_length_of(:password)
        .is_at_least(6)
        .on(:create)
    end
  end

  describe 'associations' do
    it { should have_many(:friendships).dependent(:destroy) }
    it { should have_many(:reverse_friendships).dependent(:destroy) }
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end
end
