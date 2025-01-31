class CreateTenants < ActiveRecord::Migration[7.2]
  def change
    create_table :tenants do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.string :email, null: false

      t.timestamps
    end
  end
end
