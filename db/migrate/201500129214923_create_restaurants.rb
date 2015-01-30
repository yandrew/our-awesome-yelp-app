class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.boolean :completed, :default => false
      t.integer :list_id, :default => 1

      t.timestamps
    end
  end
end
