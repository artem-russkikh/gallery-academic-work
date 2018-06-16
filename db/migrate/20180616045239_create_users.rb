class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :encrypted_password
      t.string :ldap_id
      t.integer :role
      t.string :name
      t.string :surname
      t.string :middle_name
      t.integer :age
      t.references :rank, foreign_key: true

      t.timestamps
    end
  end
end
