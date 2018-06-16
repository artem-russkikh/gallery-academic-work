# == Schema Information
#
# Table name: dispositions
#
#  id           :bigint(8)        not null, primary key
#  painting_id  :bigint(8)
#  room_id      :bigint(8)
#  reproduction :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_dispositions_on_painting_id  (painting_id)
#  index_dispositions_on_room_id      (room_id)
#

class Disposition < ApplicationRecord
  belongs_to :painting
  belongs_to :room
end
