class Role < ApplicationRecord
  # Might have to be habtm
  has_many :users, through: { join_table: :users_roles }

  belongs_to :resource,
             polymorphic: true,
             optional: true

  validates :resource_type,
            inclusion: { in: Rolify.resource_types },
            allow_nil: true

  scopify
end
