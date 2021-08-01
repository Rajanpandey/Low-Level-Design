require_relative '../Models/supervisor.rb'
require_relative 'ticket_service.rb'
require_relative '../Exceptions/ticket_not_assigned_exception.rb'
require_relative '../Exceptions/ticket_status_mismatch_exception.rb'

class SupervisorService
    def create_supervisor(name)
        supervisor = Supervisor.new(name)
        supervisor
    end

    def assign_ticket(supervisor, ticket)
        if TicketService.new.resolved_ticket?(ticket)
            supervisor.tickets << ticket
        else
            raise TicketStatusMismatch.new("The ticket #{ticket.id} status is not resolved")
        end
    end

    def verify_resolved_ticket(supervisor, ticket)
        raise TicketNotAssigned.new("The ticket #{ticket.id} isn't assigned to #{supervisor.name}") until supervisor.tickets.include?(ticket)
        TicketService.new.change_ticket_status_to_verfied(ticket)
        "#Ticket number #{ticket.id} verified by #{supervisor.name}"
    end
end
