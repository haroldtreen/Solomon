class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps
      t.integer :dispute_id
      t.string :name
      t.string :items, array: true
    end
  end
end
