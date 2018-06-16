class CreateDispositions < ActiveRecord::Migration[5.2]
  def change
    create_table :dispositions do |t|
      t.references :painting, foreign_key: true
      t.references :room, foreign_key: true
      t.boolean :reproduction

      t.timestamps
    end
  end
end
