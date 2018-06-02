class Category < ActiveRecord::Base
#  include Slugifiable::InstanceMethods
#  extend Slugifiable::ClassMethods

  has_many :book_categorys
  has_many :books, through: :book_categorys
  has_many :users, through: :books

end
