class Membership < ActiveRecord::Base
  LEVELS = %w(Manager DataEntry).freeze

  belongs_to :unit
  belongs_to :user

  validates :level, :user, :unit, presence: true
  validates :level, inclusion: { in: LEVELS }
end
