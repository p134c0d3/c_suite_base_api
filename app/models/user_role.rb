class UserRole < ApplicationRecord
  # Associations BEGIN
  belongs_to :user
  belongs_to :role
  # Associations END

  # Validations BEGIN
  validates_uniqueness_of :user, scope: :role
  # Validations END
end
