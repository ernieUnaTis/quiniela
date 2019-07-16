class CreateUsuarioPartidos < ActiveRecord::Migration[5.1]
  def change
    create_table :usuario_partidos do |t|
      t.integer :usuario_id
      t.integer :juego_id
      t.integer :goles_local
      t.integer :goles_visitante
    end
  end
end
