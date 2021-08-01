require_relative '../Models/ticket.rb'
require_relative '../Models/ticket_status.rb'

class TicketService
    def create_ticket(type, description)
        status = find_ticket_status_from_type(type)
        ticket = Ticket.new(type, description, status)
        ticket
    end

    def find_ticket_status_from_type(type)
        status = (type == TicketType::CHECKWALLETBALANCE or type == TicketType::CHANGELANGUAGE) ?
            TicketStatus::VERIFIED :
            TicketStatus::OPEN
        status
    end

    def change_ticket_status_to_resolved(ticket, resolution_comment)
        ticket.status = TicketStatus::RESOLVED
        ticket.resolution_comment = resolution_comment
    end

    def change_ticket_status_to_verfied(ticket)
        ticket.status = TicketStatus::VERIFIED
    end

    def open_ticket?(ticket)
        ticket.status == TicketStatus::OPEN
    end

    def resolved_ticket?(ticket)
        ticket.status == TicketStatus::RESOLVED
    end

    def status_of_all_tickets
        open_tickets = count_tickets_by_status(TicketStatus::OPEN)
        resolved_tickets = count_tickets_by_status(TicketStatus::RESOLVED)
        verified_tickets = count_tickets_by_status(TicketStatus::VERIFIED)
        total_tickets = open_tickets + resolved_tickets + verified_tickets

        "#{open_tickets} - OPEN TICKETS \n #{resolved_tickets} - RESOLVED TICKETS \n
            #{verified_tickets} - VERIFIED TICKETS \n #{total_tickets} - TOTAL TICKETS"
    end

    def count_tickets_by_status(status)
        tickets_array = ObjectSpace.each_object(Ticket).to_a
        tickets_array.select { |ticket| ticket.status == status }.count
    end

    def status(ticket)
        ticket.status
    end
end
