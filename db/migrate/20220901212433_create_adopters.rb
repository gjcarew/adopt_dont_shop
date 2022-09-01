class CreateAdopters < ActiveRecord::Migration[5.2]
  def change
    create_table :adopters do |t|
      t.string :name
      t.string :address
      t.string :description
      t.string :application_status

      t.timestamps
    end
  end
end
