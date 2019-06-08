class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :name
      t.text :description
      t.integer :year
      t.float :rating
      t.float :imdb_rating
      t.string :language
      t.integer :runtime
      t.integer :moviedb_id
      t.float :popularity
      t.string :poster_path
      t.index ["moviedb_id"], name: "index_movies_on_moviedb_id", unique: true

      t.timestamps
    end

    create_table :categories do |t|
      t.string :name

      t.timestamps
    end

    create_table :movie_categories do |t|
      t.references :movie, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true

      t.timestamps
    end
  end
end
