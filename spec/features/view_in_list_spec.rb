require 'rails_helper'

RSpec.describe "Assigning of Materials" do

  def log_in_as(employee)
    visit new_employee_session_path
    fill_in("employee_email", with: employee.email)
    fill_in("employee_password", with: employee.password)
    click_button("Log in")
  end

  let(:question1) { create(:question) }
  let(:question2) { create(:question, :view) }
  let(:employee1) { create(:employee, :admin) }


  it "does not allow admin to remove questions from list" do 
    question1
    log_in_as(employee1)
    visit(view_index_path)
    expect(page).to have_selector(:link_or_button, 'Add')
    expect(page).to_not have_selector(:link_or_button, 'Remove')
  end

  it "does not allow admin to add questions from list" do 
    question2
    log_in_as(employee1)
    visit(view_index_path)
    expect(page).to_not have_selector(:link_or_button, 'Add')
    expect(page).to have_selector(:link_or_button, 'Remove')
  end

  it "does not allow admin to add or remove questions from list" do 
    log_in_as(employee1)
    visit(view_index_path)
    expect(page).to_not have_selector(:link_or_button, 'Add')
    expect(page).to_not have_selector(:link_or_button, 'Remove')
  end


  
end