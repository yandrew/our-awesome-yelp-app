class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :address
      t.string :phone
      
      t.integer :distance
      t.integer :rating
      t.integer :review_count
      
      t.timestamps
    end
  end
end
