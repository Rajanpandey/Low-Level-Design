require_relative '../Services/supervisor_service.rb'
require_relative '../Services/employee_service.rb'
require_relative '../Services/ticket_service.rb'
require_relative '../Models/ticket_type.rb'
require_relative '../Models/ticket_status.rb'

describe SupervisorService do
    supervisor_service = SupervisorService.new
    employee_service = EmployeeService.new
    supervisor = supervisor_service.create_supervisor('Rajat')

    it "creates a new supervisor with name Rajat" do
        expect(supervisor.name).to eq('Rajat')
    end

    ticket = TicketService.new.create_ticket(TicketType::OTHERS, 'Need to check my wallet balance')
    employee = employee_service.create_employee('Rajan')
    employee_service.assign_ticket(employee, ticket)
    employee_service.resolve_ticket(employee, ticket, 'Problem Solved!')
    supervisor_service.assign_ticket(supervisor, ticket)
    supervisor_service.verify_resolved_ticket(supervisor, ticket)
    it "assigns the ticket to the supervisor" do
        expect(ticket.status).to eq(TicketStatus::VERIFIED)
    end
end
