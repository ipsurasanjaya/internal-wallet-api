require 'digest'

class Entity < ApplicationRecord
    has_one :wallet, dependent: :destroy

    def authenticate(name, email, password)
        if email.blank?
            return { success: false, error: "invalid email" }
        end

        entity = Entity.find_by(email: email)

        password_digest = Digest::SHA256.hexdigest(password)
        unless entity
            ActiveRecord::Base.transaction do
                entity = Entity.create(email: email, password_digest: password_digest, name: name)

                wallet = Wallet.create(entity_id: entity.id)
            end
            return { success: true, entity: entity }
        end

        if entity.password_digest == password_digest
            return { success: true, entity: entity }
        else
            return { success: false, error: "password mismatch" }
        end
    rescue => e
        { success: false, error: "#{e.message}" }
    end
end

class User < Entity; end
class Team < Entity; end
class Stock < Entity; end