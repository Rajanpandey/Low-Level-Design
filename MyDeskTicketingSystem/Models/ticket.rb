require 'securerandom'

class Ticket
    attr_accessor :status, :resolution_comment, :assigned_to
    attr_reader :id, :type, :description

    def initialize(type, description, status)
        @id = SecureRandom.uuid
        @type = type
        @description = description
        @status = status
    end
end
