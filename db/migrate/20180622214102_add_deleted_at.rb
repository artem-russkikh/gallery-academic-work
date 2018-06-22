class AddDeletedAt < ActiveRecord::Migration[5.2]
  def change
    add_column :ranks, :deleted_at, :datetime
    add_index :ranks, :deleted_at

    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at

    add_column :rooms, :deleted_at, :datetime
    add_index :rooms, :deleted_at

    add_column :painting_kinds, :deleted_at, :datetime
    add_index :painting_kinds, :deleted_at

    add_column :paintings, :deleted_at, :datetime
    add_index :paintings, :deleted_at

    add_column :dispositions, :deleted_at, :datetime
    add_index :dispositions, :deleted_at
  end
end
