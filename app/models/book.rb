class Book < ActiveRecord::Base
#  include Slugifiable::InstanceMethods
#  extend Slugifiable::ClassMethods

  belongs_to :users
  has_many :book_categories
  has_many :categories, through: :book_categories
end
