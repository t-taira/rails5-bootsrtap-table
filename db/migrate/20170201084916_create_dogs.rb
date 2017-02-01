class CreateDogs < ActiveRecord::Migration[5.0]
  def change
    create_table :dogs do |t|
      t.string :name
      t.integer :age
      t.date :birth

      t.timestamps
    end
  end
end
