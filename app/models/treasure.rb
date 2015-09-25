class Treasure < ActiveRecord::Base
  validates :email, presence: true, length: {maximum: 255},
                    uniqueness: true
end
