class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :title
      t.string :genre, array: true, default: []
      t.text :description
      t.string :developer
      t.string :image_url

      t.timestamps
    end
  end
end
