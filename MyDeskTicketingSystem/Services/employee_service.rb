require_relative '../Models/employee.rb'
require_relative 'ticket_service.rb'
require_relative '../Exceptions/ticket_not_assigned_exception.rb'
require_relative '../Exceptions/ticket_status_mismatch_exception.rb'

class EmployeeService
    def create_employee(name)
        employee = Employee.new(name)
        employee
    end

    def assign_ticket(employee, ticket)
        if TicketService.new.open_ticket?(ticket)
            employee.tickets << ticket
        else
            raise TicketStatusMismatch.new("The ticket #{ticket.id} is already resolved/closed")
        end
    end

    def resolve_ticket(employee, ticket, resolution_comment)
        raise TicketNotAssigned.new("The ticket #{ticket.id} isn't assigned to #{employee.name}") until employee.tickets.include?(ticket)
        TicketService.new.change_ticket_status_to_resolved(ticket, resolution_comment)
        "#Ticket number #{ticket.id} resolved by #{employee.name}"
    end
end
