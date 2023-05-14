# frozen_string_literal: true

# store every record duration
class AddColumnDurationToSleepRecords < ActiveRecord::Migration[7.0]
  def up
    add_column :sleep_records, :duration, :integer
  end

  def down
    remove_column :sleep_records, :duration
  end
end
