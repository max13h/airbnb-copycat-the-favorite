class CreateLenses < ActiveRecord::Migration[7.0]
  def change
    create_table :lenses do |t|
      t.string :name
      t.string :lens_type
      t.integer :price
      t.string :location
      t.references :user, null: false, foreign_key: true
      t.references :camera, null: false, foreign_key: true

      t.timestamps
    end
  end
end
