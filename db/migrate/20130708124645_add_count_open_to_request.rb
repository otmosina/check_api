class AddCountOpenToRequest < ActiveRecord::Migration
  def change
  	add_column :requests, :count_make, :integer, :default => 0
  end
end
