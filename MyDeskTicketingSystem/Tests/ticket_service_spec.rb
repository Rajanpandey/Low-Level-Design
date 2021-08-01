require_relative '../Services/ticket_service.rb'
require_relative '../Models/ticket_type.rb'
require_relative '../Models/ticket_status.rb'

describe TicketService do
    ticket_service = TicketService.new
    ticket = ticket_service.create_ticket(TicketType::CHECKWALLETBALANCE, 'Need to check my wallet balance')

    it "creates a new Ticket with type CHECKWALLETBALANCE" do
        expect(ticket.type).to eq(TicketType::CHECKWALLETBALANCE)
    end

    it "has status verified" do
        expect(ticket.status).to eq(TicketStatus::VERIFIED)
    end

    it "has verified status" do
        expect(ticket_service.status(ticket)).to eq(TicketStatus::VERIFIED)
    end

    it "returns all ticket status" do
        # expect(ticket_service.status_of_all_tickets).to eq()
    end
end
