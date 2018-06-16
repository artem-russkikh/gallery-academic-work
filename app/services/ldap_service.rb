class LdapService
  attr_reader :ldap, :search_base

  def initialize(ldap: Net::LDAP.new(host: 'localhost', port: 6389))
    @ldap = ldap
    @search_base = 'ou=user,dc=example,dc=org'

    credentials = Rails.application.credentials.ldap
    ldap.auth credentials[:login_dn], credentials[:password]
  end

  # @example
  #   LdapService.new.auth('manager@google.com', '12345678')
  # @return [Hash, nil]
  def auth(email, password)
    result = ldap.bind_as(
      base: search_base,
      filter: "(mail=#{email})",
      password: password
    )
    format_user(result.first) if result
  end

  # @example
  #   LdapService.new.add(email: 'manager@google.com', password: '12345678', name: 'Bob', surname: 'Bobber', role: 'manager')
  # @return [TrueClass, FalseClass]
  def add(email:, password:, name:, surname:, role:)
    cn = "#{name} #{surname}"
    dn = "cn=#{cn},cn=#{role},ou=user,dc=example,dc=org"
    ldap.open do |ldap_connection|
      next_uid = ldap_connection.search(
        base: @search_base,
        filter: '(uidNumber=*)',
        attributes: ['uidNumber']
      ).map { |item| item.uidNumber.first.to_i }.max + 1

      ldap_connection.add(dn: dn, attributes: {
        cn: cn,
        mail: email,
        gidNumber: detect_gidnumber_from_role(role),
        givenName: name,
        objectclass: ['inetorgperson', 'posixAccount', 'top'],
        userPassword: password,
        sn: surname,
        uidNumber: next_uid.to_s,
        uid: cn,
        homeDirectory: "/home/users/#{next_uid}"
      })

      # ldap.get_operation_result.message
    end
  end

  private

    # @return [String]
    def detect_gidnumber_from_role(role)
      result = User.roles.find { |k, v| k.to_s == role.to_s }.try(:[], 1).to_s
      raise "no such gidnumber #{role}" if result.blank?
      result
    end

    # @return [String]
    def detect_role_from_gidnumber(gidnumber)
      result = User.roles.find { |k, v| v.to_s == gidnumber.to_s }.try(:[], 0)
      raise "no such role #{gidnumber}" if result.blank?
      result
    end

    # @return [Hash]
    def format_user(ldap_user)
      {
        email: ldap_user.mail.first,
        first_name: ldap_user.givenname.first,
        last_name: ldap_user.sn.first,
        role: detect_role_from_gidnumber(ldap_user.gidnumber.first),
        ldap_id: ldap_user.uidnumber.first
      }
    end
end
