require 'rails_helper'



RSpec.describe "User Profile" do


  def log_in_as(employee)
    visit new_employee_session_path
    fill_in("employee_email", with: employee.email)
    fill_in("employee_password", with: employee.password)
    click_button("Log in")
  end

  def answer_question(answer)
    visit answer_new_path(id: employee1.id)
    fill_in("answer_answer", with: answer.answer)
    click_button("Answer Question")
  end

  let(:employee1) { create(:employee) }
  let(:employee2) { create(:employee, :admin) }
  let(:question1) { create(:question) }
  let(:question2) { create(:question, :opt_numerical) }
  let(:question3) { create(:question, :opt_choice) }
  
  let(:choice1) { create(:choice) }

  it "employees can view their profile page" do 
    log_in_as(employee1)
    visit(homepage_path(id: employee1.id))
    expect(page).to have_content(employee1.name)
  end

  it "employees can view questions created by admin through their profile page" do 
    question1
    log_in_as(employee1)
    visit(homepage_path(id: employee1.id))
    expect(page).to have_content(question1.question)  
  end

  it "allows employee to answer a question with text as answer type" do
    question1
    log_in_as(employee1)
    visit(homepage_path(id: employee1.id))
    expect(page).to have_content(question1.question)
    click_link('Answer Question')
    expect(page).to have_content('Answer Question')
    expect(page).to have_content('Submit')
  end


  it "allows employee to answer a question with numerical as answer type" do
    question2
    log_in_as(employee1)
    visit(homepage_path(id: employee1.id))
    expect(page).to have_content(question2.question)
    click_link('Answer Question')
    expect(page).to have_content('Answer Question')
    expect(page).to have_content('Submit')
  end


  it "allows employee to answer a question with choice as answer type" do
    question3
    log_in_as(employee1)
    visit(homepage_path(id: employee1.id))
    expect(page).to have_content(question3.question)
    click_link('Answer Question')
    expect(page).to have_content('Answer Question')
    expect(page).to have_content('Submit')
  end







  
end