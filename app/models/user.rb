class User < ActiveRecord::Base
	validates :email, presence: true
	validates :email, uniqueness: true
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :save
	validates :password, presence: true

	include BCrypt
	  
	def password
	    @password ||= Password.new(password_hash)	
	end

	def password=(new_password)
		@password = Password.create(new_password)
		self.password_hash = @password
	end

	def self.authenticate(user_info)
	    email = user_info[:email]
	    password = user_info[:password]

	    user = User.find_by_email(email) 
		return user if user && user.password == password

	    nil 
	  end

end
