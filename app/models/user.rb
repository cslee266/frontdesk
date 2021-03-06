class User < ApplicationRecord
  include Clearance::User

  has_many :authentications, dependent: :destroy
  has_one :unit
  has_many :messages
  has_many :conversations, foreign_key: :sender_id
  has_many :reservations
  has_many :visitors
  has_many :maintenances

	def self.create_with_auth_and_hash(authentication, auth_hash)
	  user = self.create!(
	    name: auth_hash["extra"]["raw_info"]["name"],
	    email: auth_hash["extra"]["raw_info"]["email"],
	    password: SecureRandom.hex(5)
	  )
	  user.authentications << authentication
	  return user
	end

	# grab fb_token to access Facebook for user data
	def fb_token
	  x = self.authentications.find_by(provider: 'facebook')
	  return x.token unless x.nil?
	end

	mount_uploader :avatar, AvatarUploader

	enum role: [:homeowner, :superadmin]

end
