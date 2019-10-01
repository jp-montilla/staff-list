require 'rails_helper'

RSpec.describe "Assigning of Materials" do

  def log_in_as(employee)
    visit new_employee_session_path
    fill_in("employee_email", with: employee.email)
    fill_in("employee_password", with: employee.password)
    click_button("Log in")
  end

  let(:employee1) { create(:employee) }
  let(:material) { create(:material) }
  let(:material2) { create(:material, employee_id: employee1.id) }
  let(:employee2) { create(:employee, :admin) }

  it "allows admin to view material assignment page" do 
    log_in_as(employee2)
    visit(assign_index_path)
    expect(current_path).to eq(assign_index_path)
  end

  it "displays employee without material assign to it" do 
    employee1
    log_in_as(employee2)
    visit(assign_index_path)
    expect(page).to have_content("NONE")
  end

  it "allows admin to assign a material" do 
    employee1
    material
    log_in_as(employee2)
    visit(assign_index_path)
    click_link('Assign material')
    expect(page).to have_content("Random Item")
  end

  it "does not allow admin to assign a material if there are no material available" do 
    employee1
    material2
    log_in_as(employee2)
    visit(assign_index_path)
    expect(page).to_not have_selector(:link_or_button, 'Assign material')
  end

  it "allows admin to assign a material if there are materials available" do 
    employee1
    material
    log_in_as(employee2)
    visit(assign_index_path)
    expect(page).to have_selector(:link_or_button, 'Assign material')
  end

  it "allows admin to assign a material" do 
    employee1
    material
    log_in_as(employee2)
    visit(assign_index_path)
    click_link('Assign material')
    expect(page).to have_content("Random Item")
  end

  it "allows admin to remove assignment of material to an employee" do 
    employee1
    material2
    log_in_as(employee2)
    visit(assign_index_path)
    expect(page).to have_selector(:link_or_button, 'Remove')
  end

  it "does not allow admin to remove assignment of material to an employee if no material is assigned" do 
    employee1
    material
    log_in_as(employee2)
    visit(assign_index_path)
    expect(page).to_not have_selector(:link_or_button, 'Remove')
  end


  
end