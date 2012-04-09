class AddIsBlockableToViewObjects < ActiveRecord::Migration
  def change
		add_column :view_objects, :is_blocked, :boolean, :default => false
    add_index  :view_objects, :is_blocked
  end
end
