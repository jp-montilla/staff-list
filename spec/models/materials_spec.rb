require 'rails_helper'

RSpec.describe Material, type: :model do

  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :material_type }
    it { is_expected.to validate_presence_of :status }
  end

  it "creates a material record without assigning to employee" do
    material = create(:material)
    expect(material).to be_valid
  end

  it "creates a material record with assigning to employee" do
    material = create(:material, :assigned)
    expect(material).to be_valid
  end

  it "should not accept record without name" do
    foo = build(:material, name: nil)
    expect(foo).to_not be_valid
  end

  it "should not accept record without material type" do
    foo = build(:material, material_type: nil)
    expect(foo).to_not be_valid
  end

  it "should not accept record without status" do
    foo = build(:material, status: nil)
    expect(foo).to_not be_valid
  end

  it "should not accept record without name, material type and status" do
    foo = build(:material, name: nil, material_type: nil, status: nil)
    expect(foo).to_not be_valid
  end

end