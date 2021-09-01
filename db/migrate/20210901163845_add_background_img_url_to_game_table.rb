class AddBackgroundImgUrlToGameTable < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :background_image_url, :string
  end
end
