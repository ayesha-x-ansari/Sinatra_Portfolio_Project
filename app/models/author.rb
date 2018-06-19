require_all 'app'
class Author < ActiveRecord::Base
  has_secure_password
  validates_presence_of :name, :email, :password, :moms_maiden_name

  include Slugifiable::InstanceMethods
  extend  Slugifiable::ClassMethods

  has_many :books
  has_many :categories, through: :books
end
