class User < ApplicationRecord
  validates :username,
            :first_name,
            :last_name,
            :email, presence: true
end
