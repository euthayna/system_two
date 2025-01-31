class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :description
      t.string :use_unity, null: false

      t.timestamps
    end
  end
end
