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
#

class Room < ApplicationRecord
end
