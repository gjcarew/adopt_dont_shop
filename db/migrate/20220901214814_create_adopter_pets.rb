class CreateAdopterPets < ActiveRecord::Migration[5.2]
  def change
    create_table :adopter_pets do |t|
      t.references :pet, foreign_key: true
      t.references :adopter, foreign_key: true

      t.timestamps
    end
  end
end
