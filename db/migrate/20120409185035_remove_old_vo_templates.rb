class RemoveOldVoTemplates < ActiveRecord::Migration
  def up
    template_names = ["v2_single_col_list",
    "v2_triple_col_large_2",
    "v2_double_col_feature",
    "v2_single_col_small_list",
    "v2_single_col_item",
    "v2_double_col_item",
    "v2_double_col_item_list",
    "v2_double_col_triple_item",
    "v2_double_col_feature_triple_item"]
    template_names.each do |tn|
      tn = ViewObjectTemplate.find_by_name(tn)
      tn.destroy
    end
  end

  def down
  end
end
