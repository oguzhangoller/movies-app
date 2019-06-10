class CreateActors < ActiveRecord::Migration[5.2]
  def change
    create_table :actors do |t|
      t.string :name
      t.float :popularity
      t.string :poster_path

      t.timestamps
    end

    create_table :movie_actors do |t|
      t.references :movie, index: true, foreign_key: true
      t.references :actor, index: true, foreign_key: true

      t.timestamps
    end
  end
end
