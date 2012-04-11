class AddPreviewToViewObjectTemplates < ActiveRecord::Migration
  def change
    add_column :view_object_templates, :preview, :string, :default => nil
  end
end
