class Addstatustodispute < ActiveRecord::Migration
  def change
  	add_column :disputes, :status, :string
  end
end
