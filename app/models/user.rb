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
#
# Indexes
#
#  index_users_on_rank_id  (rank_id)
#

class User < ApplicationRecord
  attr_accessor :password

  enum role: { painter: 0, manager: 1, admin: 2 }

  belongs_to :rank
end
