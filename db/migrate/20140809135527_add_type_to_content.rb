class AddTypeToContent < ActiveRecord::Migration
  def change
  	add_column :contents, :social_media_site, :string
  end
end
