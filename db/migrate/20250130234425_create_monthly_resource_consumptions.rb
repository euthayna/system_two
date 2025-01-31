class CreateMonthlyResourceConsumptions < ActiveRecord::Migration[7.2]
  def change
    create_table :monthly_resource_consumptions do |t|
      t.references :tenant, foreign_key: true
      t.references :product, foreign_key: true
      t.decimal :total_used, default: 0, null: false
      t.string :use_unity, null: false
      t.decimal :total_cost, null: false
      t.string :interval, null: false

      t.timestamps
    end
  end
end
