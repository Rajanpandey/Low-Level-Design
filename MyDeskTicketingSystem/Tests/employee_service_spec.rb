require_relative '../Services/employee_service.rb'
require_relative '../Services/ticket_service.rb'
require_relative '../Models/ticket_type.rb'
require_relative '../Models/ticket_status.rb'

describe EmployeeService do
    employee_service = EmployeeService.new
    employee = employee_service.create_employee('Rajan')

    it "creates a new Employee with name Rajan" do
        expect(employee.name).to eq('Rajan')
    end

    ticket = TicketService.new.create_ticket(TicketType::OTHERS, 'Need to check my wallet balance')
    employee_service.assign_ticket(employee, ticket)
    it "assigns the ticket to the employee" do
        expect(employee.tickets.count).to eq(1)
    end

    employee_service.resolve_ticket(employee, ticket, 'Problem Solved!')
    it "resolves the ticket" do
        expect(ticket.resolution_comment).to eq('Problem Solved!')
    end
end
