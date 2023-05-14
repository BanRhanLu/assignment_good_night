# frozen_string_literal: true

# rename clock_in clock_out
class RenameColumnClockInAndClockOutToSleepRecords < ActiveRecord::Migration[7.0]
  def up
    rename_column :sleep_records, :clock_in, :sleep
    rename_column :sleep_records, :clock_out, :wake_up
  end

  def down
    rename_column :sleep_records, :sleep, :clock_in
    rename_column :sleep_records, :wake_up, :clock_out
  end
end
