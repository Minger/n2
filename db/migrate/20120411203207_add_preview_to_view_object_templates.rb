class AddPreviewToViewObjectTemplates < ActiveRecord::Migration
  def change
    add_column :view_object_templates, :preview, :string, :default => nil

    vt = ViewObjectTemplate.find_by_name "v3_double_col_1_large_2_small"
    vt.update_attribute :preview, "template_previews/Double-One-Large-Two-Small.png"
     
    vt = ViewObjectTemplate.find_by_name "v3_double_col_2_medium"
    vt.update_attribute :preview, "template_previews/Double-Two-Medium.png"

    vt = ViewObjectTemplate.find_by_name "v3_triple_col_1_large_4_small"
    vt.update_attribute :preview, "template_previews/Triple-1-Large-4-Small.png"
    
  
    vt = ViewObjectTemplate.find_by_name "v3_triple_col_4_small"
    vt.update_attribute :preview, "template_previews/Triple-Four-Small.png"
    
    
    vt = ViewObjectTemplate.find_by_name "v3_triple_col_3_medium"
    vt.update_attribute :preview, "template_previews/Triple-Three-Medium.png"
  
    
    vt = ViewObjectTemplate.find_by_name "v3_triple_col_2_large"
    vt.update_attribute :preview, "template_previews/Triple-Two-Large.png"
    
    vt = ViewObjectTemplate.find_by_name "v2_single_col_list_with_profile"
    vt.update_attribute :preview, "template_previews/single-col-newest-items-with-pics.png"
    
    vt = ViewObjectTemplate.find_by_name "v2_single_facebook_widget"
    vt.update_attribute :preview, "template_previews/single-col-facebook-recommendations.png"
    
    vt = ViewObjectTemplate.find_by_name "v3_single_col_item_list"
    vt.update_attribute :preview, "template_previews/single-col-universal-top-items-list.png"
    
    vt = ViewObjectTemplate.find_by_name "v2_single_col_user_list"
    vt.update_attribute :preview, "template_previews/single-col-user-images.png"
    
    vt = ViewObjectTemplate.find_by_name "v2_welcome_panel"
    vt.update_attribute :preview, "template_previews/single-col-welcome-panel.png"
  end
end
