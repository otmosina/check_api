class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :partner_id
      t.string :url
      t.string :parametres

      t.timestamps
    end
  end
end
