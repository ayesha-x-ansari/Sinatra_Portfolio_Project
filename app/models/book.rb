class Book < ActiveRecord::Base
#  include Slugifiable::InstanceMethods
#  extend Slugifiable::ClassMethods

  belongs_to :user
  has_many :book_categorys
  has_many :categorys, through: :book_categorys
end
