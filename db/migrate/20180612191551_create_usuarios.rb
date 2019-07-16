class CreateUsuarios < ActiveRecord::Migration[5.1]
  def change
    create_table :usuarios do |t|
      t.string :nombre
      t.integer :id
      t.boolean :registro
      t.timestamps
    end
  end
end
