class User < ApplicationRecord
  has_many :sleep_records
  has_many :follow_ships
end
