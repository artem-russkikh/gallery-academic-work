json.extract! user, :id, :email, :encrypted_password, :ldap_id, :role, :name, :surname, :middle_name, :age, :rank_id, :created_at, :updated_at
json.url user_url(user, format: :json)
