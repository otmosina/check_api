class AddUniqueIndexToRequest < ActiveRecord::Migration
  def change
  	add_index   :requests,  [:partner_id, :parametres, :url ], :unique => true
  end
end
