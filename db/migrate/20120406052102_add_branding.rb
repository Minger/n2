class AddBranding < ActiveRecord::Migration
  def up
    create_table :brandings do |t|
      t.binary :logo
      t.binary :favicon
    end
  end

  def down
  end
end
