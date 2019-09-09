require 'rails_helper'

RSpec.describe "with users and roles" do

  def log_in_as(employee)
    visit new_employee_session_path
    fill_in("employee_email", with: employee.email)
    fill_in("employee_password", with: employee.password)
    click_button("Log in")
  end

  let(:employee1) { Employee.create(email: "test@example.com", password: "password", role: 'Employee') }
  let(:employee2) { Employee.create(email: "test@example.com", password: "password", role: 'Admin') }

  it "allows a logged-in employee to view the index page" do 
    log_in_as(employee1)
    visit(root_path)
    expect(current_path).to eq(root_path)
  end


  it "does not allow a employee to see the index page if not logged in" do 
    visit(root_path)
    expect(current_path).to eq(new_employee_session_path)
  end

  
end