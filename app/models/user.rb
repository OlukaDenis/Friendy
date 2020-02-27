class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, class_name: 'Friendship', foreign_key: 'user_id', dependent: :destroy
  has_many :reverse_friendships, class_name: 'Friendship', foreign_key: :friend_id, dependent: :destroy

  # Listing all confirmed friends
  def friends
    friends_arr = friendships.map do |friendship|
      friendship.friend if friendship.status
    end

    friends_arr += reverse_friendships.map do |friendship|
      friendship.user if friendship.status
    end

    friends_arr.compact
  end

  # Outgoing friend requests
  def outgoing_requests
    friends_arr = friendships.map { |friendship| friendship.friend unless friendship.status }.compact
  end

  # Incoming friend requests
  def incoming_requests
    friends_arr = reverse_friendships.map { |friendship| friendship.user unless friendship.status }.compact
  end

  # Confirming incoming friend requests
  def confirm_friend(user)
    reverse_friendships.find { |friendship| user == friendship.user }.update(status: true)
    # friendships.create(friend: user, status: true)
  end

  # Remove friend
  def remove_reverse_friend(friend)    
      friendships.delete friend
  end

  def remove_friend(friend)
    reverse_friendships.delete friend
  end
 

  # Check whether a user is a friend
  def is_friend?(user)
    friends.include?(user)
  end
end
