class BadRequestException < StandardError
    def initialize(message)
        super(message)
    end
end
