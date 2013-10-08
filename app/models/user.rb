class User < ActiveRecord::Base
  attr_accessor :password
#  attr_accessible :nom, :email, :password, :password_confirmation
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :nom, :presence => true,
                  :length => {:maximum => 50}
  validates :email, :presence => true,
                    :format => email_regex,
                    :uniqueness => {:case_sensitive => false}
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => {:within => 6..40}
  before_save :encrypt_password

  #Retourne vrai si le mot de passe correspond
  def has_password?(password_soumis)
    #Compare encrypted_password avec la version cryptée de password_soumis
  end

  private

    def encrypt_password
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      string #implémentation provisoire
    end
end
