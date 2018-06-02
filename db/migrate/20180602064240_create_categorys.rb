class CreateCategorys < ActiveRecord::Migration[5.2]
  def change
    create_table :categorys do |t|
      t.string :name
    end

  end
end
