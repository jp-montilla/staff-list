require 'rails_helper'

RSpec.describe Employee, type: :model do

  describe "validations" do
    it { is_expected.to validate_uniqueness_of :name }
    it { is_expected.to validate_presence_of :name }
  end

  describe "associations" do
    it { is_expected.to have_many(:material) }
    it { is_expected.to have_many(:answer) }
  end
  
  it "creates an employee record" do
    employee = create(:employee)
    expect(employee.email).to eq("something@example.com")
    expect(employee.name).to eq("something")
    expect(employee.password).to eq("password")
  end

  it "should have a unique email" do
    create(:employee)
    foo = build(:employee, name: 'usernameChange')
    expect(foo).to_not be_valid
  end

  it "should have a unique username" do
    create(:employee)
    foo = build(:employee, email: 'emailChange@email.com')
    expect(foo).to_not be_valid
  end

  it "should have the same password and password confimation" do
    foo = build(:employee, password_confirmation: 'different')
    expect(foo).to_not be_valid
  end

end