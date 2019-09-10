require 'rails_helper'

RSpec.describe Question, type: :model do

  describe "validations" do
    it { is_expected.to validate_presence_of :question }
    it { is_expected.to validate_presence_of :answer_type }
    it { is_expected.to validate_presence_of :view_to_list }
  end

  describe "associations" do
    it { is_expected.to have_many(:choice) }
    it { is_expected.to have_many(:answer) }
  end
  
  it "creates a choice record" do
    foo = create(:question)
    expect(foo).to be_valid
  end

  it "should accept record with view to list set to true" do
    foo = create(:question, :view)
    expect(foo).to be_valid
  end

  it "should not accept record without question" do
    foo = build(:question, question: nil)
    expect(foo).to_not be_valid
  end

  it "should not accept record without answer type" do
    foo = build(:question, answer_type: nil)
    expect(foo).to_not be_valid
  end

  it "should not accept record without view to list" do
    foo = build(:question, view_to_list: nil)
    expect(foo).to_not be_valid
  end

  it "should not accept record without question, answer type and view to list" do
    foo = build(:question, question: nil, answer_type: nil, view_to_list: nil)
    expect(foo).to_not be_valid
  end

  

end