# == Schema Information
#
# Table name: ranks
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#
# Indexes
#
#  index_ranks_on_deleted_at  (deleted_at)
#

class Rank < ApplicationRecord
  acts_as_paranoid

  has_many :users
end
