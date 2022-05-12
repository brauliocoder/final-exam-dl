class Role < ApplicationRecord
  enum title: {
    ally: 'ally',
    headquarter_admin: 'headquarter_admin',
    depot_admin: 'depot_admin',
    full_admin: 'channel_depot_admin'
  }
end
