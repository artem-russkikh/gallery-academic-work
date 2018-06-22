# == Schema Information
#
# Table name: painting_kinds
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#
# Indexes
#
#  index_painting_kinds_on_deleted_at  (deleted_at)
#

class PaintingKind < ApplicationRecord
  acts_as_paranoid

  has_many :paintings
end
