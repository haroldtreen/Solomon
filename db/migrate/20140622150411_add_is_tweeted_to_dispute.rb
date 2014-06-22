class AddIsTweetedToDispute < ActiveRecord::Migration
  def change
  	add_column :disputes, :is_tweeted, :boolean, default: false
  end
end
