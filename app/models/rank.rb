# == Schema Information
#
# Table name: ranks
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Rank < ApplicationRecord
  has_many :users
end
