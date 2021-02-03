class CreateLinkStats < ActiveRecord::Migration[5.2]
  def change
    create_table :link_stats do |t|
      t.text :event
      t.text :ip_address
      t.text :country
      t.references :link

      t.timestamps
    end
  end
end
