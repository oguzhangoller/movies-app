class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :name
      t.text :description
      t.integer :year
      t.float :rating

      t.timestamps
    end

    create_table :categories do |t|
      t.string :name

      t.timestamps
    end

    create_table :movie_categories do |t|
      t.belongs_to :movie, index: true
      t.belongs_to :category, index: true

      t.timestamps
    end
  end
end
