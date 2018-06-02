class User < ActiveRecord::Base
  has_secure_password
#  include Slugifiable::InstanceMethods
#  extend Slugifiable::ClassMethods
  has_many :books
  has_many :categoryies, through: :books
end
