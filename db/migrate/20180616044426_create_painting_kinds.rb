class CreatePaintingKinds < ActiveRecord::Migration[5.2]
  def change
    create_table :painting_kinds do |t|
      t.string :title

      t.timestamps
    end
  end
end
