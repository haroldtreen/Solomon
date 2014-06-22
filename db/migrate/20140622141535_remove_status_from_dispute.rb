class RemoveStatusFromDispute < ActiveRecord::Migration
  def change
  	remove_column :disputes, :status
  end
end
