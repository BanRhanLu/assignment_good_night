# frozen_string_literal: true

# every user friend ship
class CreateFollowShips < ActiveRecord::Migration[7.0]
  def up
    create_table(:follow_ships) do |t|
      t.integer(:user_id)
      t.integer(:following_id)
      t.timestamps
    end
  end

  def down
    drop_table(:follow_ships)
  end
end
