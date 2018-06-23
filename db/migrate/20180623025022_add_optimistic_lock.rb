class AddOptimisticLock < ActiveRecord::Migration[5.2]
  def change
    add_column :paintings, :lock_version, :integer, default: 0
  end
end
