class CreateContracts < ActiveRecord::Migration[7.2]
  def change
    create_table :contracts do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.string :status, default: 'active'

      t.timestamps
    end
  end
end
