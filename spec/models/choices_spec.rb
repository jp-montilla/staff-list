require 'rails_helper'

RSpec.describe Choice, type: :model do

  describe "validations" do
    it { is_expected.to validate_presence_of :choice }
  end

  describe "associations" do
    it { is_expected.to belong_to(:question) }
  end
  
  it "creates a choice record" do
    foo = create(:choice)
    expect(foo).to be_valid
  end

  it "should not accept record without question" do
    foo = build(:choice, question: nil)
    expect(foo).to_not be_valid
  end

  it "should not accept record without choice" do
    foo = build(:choice, choice: nil)
    expect(foo).to_not be_valid
  end

  it "should not accept record without question and choice" do
    foo = build(:choice, question: nil, choice: nil)
    expect(foo).to_not be_valid
  end

  

end