class Entity < ApplicationRecord
    has_one :wallet, dependent: :destroy

    after_create :create_wallet
end

class User < Entity; end
class Team < Entity; end
class Stock < Entity; end