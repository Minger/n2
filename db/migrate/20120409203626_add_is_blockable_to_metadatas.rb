class AddIsBlockableToMetadatas < ActiveRecord::Migration
  def change
		add_column :metadatas, :is_blocked, :boolean, :default => false
    add_index  :metadatas, :is_blocked
  end
end
