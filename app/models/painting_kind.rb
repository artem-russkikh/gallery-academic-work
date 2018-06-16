# == Schema Information
#
# Table name: painting_kinds
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PaintingKind < ApplicationRecord
end
