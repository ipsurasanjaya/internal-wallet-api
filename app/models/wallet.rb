class Wallet < ApplicationRecord
    belongs_to :entity
    has_many :transactions
end
