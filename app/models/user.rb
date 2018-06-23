# == Schema Information
#
# Table name: users
#
#  id                 :bigint(8)        not null, primary key
#  email              :string
#  encrypted_password :string
#  ldap_id            :string
#  role               :integer
#  name               :string
#  surname            :string
#  middle_name        :string
#  age                :integer
#  rank_id            :bigint(8)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  deleted_at         :datetime
#
# Indexes
#
#  index_users_on_deleted_at  (deleted_at)
#  index_users_on_rank_id     (rank_id)
#

class User < ApplicationRecord
  ROLE_TRANSLATIONS = {
    painter: 'художник',
    manager: 'управляющий',
    admin: 'администратор'
  }.freeze

  attr_accessor :password

  enum role: { painter: 502, manager: 501, admin: 500 }

  acts_as_paranoid

  belongs_to :rank, optional: true
  has_many :paintings

  def self.roles_translated
    Hash[roles.map { |k, v| [ROLE_TRANSLATIONS[k.to_sym], v] }]
  end
end
