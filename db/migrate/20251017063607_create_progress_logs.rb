class CreateProgressLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :progress_logs do |t|
      t.references :habit, null: false, foreign_key: true
      t.boolean :completed
      t.date :logged_date

      t.timestamps
    end
  end
end
