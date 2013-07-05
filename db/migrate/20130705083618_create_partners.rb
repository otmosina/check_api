class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :app_id
      t.string :secret

      t.timestamps
    end
  end
end
