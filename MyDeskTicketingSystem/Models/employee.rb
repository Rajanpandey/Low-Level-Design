require 'securerandom'

class Employee
    attr_accessor :tickets
    attr_reader :id, :name

    def initialize(name)
        @id = SecureRandom.uuid
        @name = name
        @tickets = Array.new
    end
end
