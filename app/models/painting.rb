# == Schema Information
#
# Table name: paintings
#
#  id               :bigint(8)        not null, primary key
#  title            :string
#  painting_kind_id :bigint(8)
#  user_id          :bigint(8)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_paintings_on_painting_kind_id  (painting_kind_id)
#  index_paintings_on_user_id           (user_id)
#

class Painting < ApplicationRecord
  belongs_to :painting_kind
  belongs_to :user
end
