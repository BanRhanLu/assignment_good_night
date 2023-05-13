# frozen_string_literal: true

# record user every sleep detail
class CreateSleepRecords < ActiveRecord::Migration[7.0]
  def up
    create_table(:sleep_records) do |t|
      t.integer(:user_id)
      t.datetime(:clock_in)
      t.datetime(:clock_out)
      t.timestamps
    end
  end

  def down
    drop_table(:sleep_records)
  end
end
