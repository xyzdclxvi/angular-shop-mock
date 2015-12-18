class AddImageLinkToProducts < ActiveRecord::Migration
  def change
    add_column :products, :image_link, :string
  end
end
