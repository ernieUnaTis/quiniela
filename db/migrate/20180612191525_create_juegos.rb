class CreateJuegos < ActiveRecord::Migration[5.1]
  def change
    create_table :juegos do |t|
      t.string :local
      t.string :goles_local
      t.string :visitante
      t.string :goles_visitante
      t.integer :juego_id

      t.timestamps
    end
  end
end
