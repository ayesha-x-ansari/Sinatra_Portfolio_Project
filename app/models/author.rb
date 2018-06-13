require_all 'app'
class Author < ActiveRecord::Base
  has_secure_password
 include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  has_many :books
  has_many :categories, through: :books
end
