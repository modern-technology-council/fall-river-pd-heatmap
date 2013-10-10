class CreateCallLogs < ActiveRecord::Migration
  def change
    create_table :call_logs do |t|
      t.date :for_date
      t.string :filename

      t.timestamps
    end
  end
end
