# == Schema Information
#
# Table name: rooms
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  position   :string
#  area       :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#
# Indexes
#
#  index_rooms_on_deleted_at  (deleted_at)
#

class Room < ApplicationRecord
  acts_as_paranoid

  has_many :dispositions
  has_many :paintings, through: :dispositions
end
