require_all 'app'
class Category < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  has_many :book_categories
  has_many :books, through: :book_categories
  has_many :users, through: :books

end
