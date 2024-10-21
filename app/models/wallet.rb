class Wallet < ApplicationRecord
    belongs_to :entity
    has_many :transactions

    def self.find_by_id(id)
        find(id)
    end
end
