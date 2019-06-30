class AddColumnsToActor < ActiveRecord::Migration[5.2]
  def change
    add_column :actors, :description, :string
    add_column :actors, :gender, :integer
    add_column :actors, :birth_date, :date
    add_column :actors, :birth_place, :string
  end
end
