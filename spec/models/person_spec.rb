require 'rails_helper'

RSpec.describe Person, type: :model do
  it "requires the presence of a first name" do
    expect(Person.new("first_name" => "", "last_name" => "Vadar", "gender" => "male", "species" => "Human", "vehicle" => "Tiefighter", "weapon" => "lightsaber")).not_to be_valid
  end

  it "requires the presence of a gender" do
    expect(Person.new("first_name" => "Darth", "last_name" => "Vadar", "gender" => "", "species" => "Human", "vehicle" => "Tiefighter", "weapon" => "lightsaber")).not_to be_valid
  end

  it "requires the presence of a species" do
    expect(Person.new("first_name" => "Darth", "last_name" => "Vadar", "gender" => "Male", "species" => "", "vehicle" => "Tiefighter", "weapon" => "lightsaber")).not_to be_valid
  end

  it "does not require the presence of a last name" do
    expect(Person.new("first_name" => "Darth", "last_name" => "", "gender" => "male", "species" => "Human", "vehicle" => "Tiefighter", "weapon" => "lightsaber")).to be_valid
  end

  context 'person should' do
    let(:person) {
        Person.create("first_name": "Darth", "last_name": "Vadar", "gender": "male", "species": "Human", "vehicle": "Tiefighter", "weapon": "lightsaber")
    }
   
    it "have an affiliation" do
      affiliation = Affiliation.create("affiliation_name": "Sith")
      person.affiliations << [affiliation]
      expect(person.affiliations.count).to eq(1)
    end
  
    it "has no affiliation attached" do
      expect(person.affiliations.count).to eq(0)
    end
  end
end
