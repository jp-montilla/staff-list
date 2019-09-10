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

end