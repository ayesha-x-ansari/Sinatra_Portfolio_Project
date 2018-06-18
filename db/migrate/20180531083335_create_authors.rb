class CreateAuthors < ActiveRecord::Migration[4.2]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :moms_maiden_name
    end

  end
end
