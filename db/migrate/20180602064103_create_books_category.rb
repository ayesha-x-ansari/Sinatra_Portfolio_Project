class CreateBookCategorys < ActiveRecord::Migration[5.2]
  def change
    create_table :bookcategorys do |t|
      t.integer :book_id
      t.integer :category_id
    end

  end
end
