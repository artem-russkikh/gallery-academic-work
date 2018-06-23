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
#  deleted_at       :datetime
#  lock_version     :integer          default(0)
#
# Indexes
#
#  index_paintings_on_deleted_at        (deleted_at)
#  index_paintings_on_painting_kind_id  (painting_kind_id)
#  index_paintings_on_user_id           (user_id)
#

class Painting < ApplicationRecord
  acts_as_paranoid

  belongs_to :painting_kind
  belongs_to :user

  has_one_attached :image

  has_many :dispositions
  has_many :rooms, through: :dispositions
end
