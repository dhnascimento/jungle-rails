class User < ActiveRecord::Base

  has_secure_password
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence:true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true
  before_save { email.downcase! }
  before_save { first_name.strip! }
  before_save { last_name.strip! }



  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    if user && user.authenticate(password)
       user
    else
      nil
    end
  end



  # def authentication(email, password)
  #   user = User.find_by_email(email.strip)
  #   # If the user exists AND the password entered is correct.
  #   return user && user.authenticate(params[:password])
  #     # Save the user id inside the browser cookie. This is how we keep the user 
  #     # logged in when they navigate around our website.
  # end

end
