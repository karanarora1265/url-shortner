class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.text :long_url

      t.timestamps
    end
  end
end
