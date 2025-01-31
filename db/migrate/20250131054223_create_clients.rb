class CreateClients < ActiveRecord::Migration[7.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :client_id
      t.string :client_secret

      t.timestamps
    end
  end
end
