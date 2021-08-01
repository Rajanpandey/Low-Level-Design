class TicketStatusMismatch < StandardError
    def initialize(message)
        super(message)
    end
end
