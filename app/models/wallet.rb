class Wallet < ApplicationRecord
    belongs_to :entity
    has_many :transactions

    def self.find_wallet(id)
        find(id)
    end
end
