class Transaction < ApplicationRecord
    belongs_to :wallet
    enum type: [
        credit: 0,
        debit: 1
    ]
end
