class CreateBookCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :bookcategories do |t|
      t.integer :book_id
      t.integer :category_id
    end

  end
end