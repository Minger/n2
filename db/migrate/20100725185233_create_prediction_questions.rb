class CreatePredictionQuestions < ActiveRecord::Migration
  def self.up
    create_table :prediction_questions do |t|
      t.integer :prediction_group_id
      t.string :title
      t.string :type
      t.string :status
      t.integer :user_id
      t.boolean :is_approved, :default => false
      t.integer  :votes_tally,                 :default => 0
      t.integer  :comments_count,              :default => 0
      t.boolean  :is_blocked,                  :default => false
      t.boolean  :is_featured,                 :default => false
      t.datetime :featured_at
      t.timestamps
    end
  end

  def self.down
    drop_table :prediction_questions
  end
end
