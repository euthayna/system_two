class CreatePricings < ActiveRecord::Migration[7.2]
  def change
    create_table :pricings do |t|
      t.references :product, foreign_key: true
      t.decimal :price_per_unit, null: false
      t.string :currency, default: 'BRL', null: false

      t.timestamps
    end
  end
end
