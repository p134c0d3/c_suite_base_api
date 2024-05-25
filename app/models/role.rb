class Role < ApplicationRecord
    # when creating a role it should use snake case i.e. 'admin_role'
  validates_uniqueness_of :slug, presence: true

  scope :available_roles, -> { pluck(:slug)}

  def self.valid_role?(role)
    stringfield_role = role.to_s.downcase.underscore
    stringfield_role.in?(available_roles)
  end
end
