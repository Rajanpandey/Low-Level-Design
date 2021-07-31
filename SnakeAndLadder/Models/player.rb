require 'securerandom'

class Player
    attr_reader :id, :name

    def initialize(name)
        @id = SecureRandom.uuid
        @name = name
    end
end
