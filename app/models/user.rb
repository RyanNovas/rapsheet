class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable

  validates :username,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    }

  belongs_to :state
  has_many :comments

  # def self.find_for_database_authentication
  #     conditions = warden_conditions.dup
  #     if login = conditions.delete(:login)
  #       where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  #     else
  #       where(conditions.to_hash).first
  #     end
  #   end
end
