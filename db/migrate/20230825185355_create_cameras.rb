class CreateCameras < ActiveRecord::Migration[7.0]
  def change
    create_table :cameras do |t|
      t.string :model
      t.string :brand

      t.timestamps
    end
  end
end
