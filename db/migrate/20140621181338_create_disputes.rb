class CreateDisputes < ActiveRecord::Migration
  def change
    create_table :disputes do |t|

      t.timestamps
    end
  end
end
