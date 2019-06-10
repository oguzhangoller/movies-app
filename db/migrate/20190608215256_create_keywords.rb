class CreateKeywords < ActiveRecord::Migration[5.2]
  def change
    create_table :keywords do |t|
      t.string :name

      t.timestamps
    end

    create_table :movie_keywords do |t|
      t.references :movie, index: true, foreign_key: true
      t.references :keyword, index: true, foreign_key: true

      t.timestamps
    end
  end
end
