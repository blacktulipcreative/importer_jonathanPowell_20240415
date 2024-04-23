require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:person) {
    Person.create("first_name": "Darth", "last_name": "Vadar", "gender": "male", "species": "Human", "vehicle": "Tiefighter", "weapon": "lightsaber")
  }

  it "successfully relate to person" do
    first_location = Location.create("location_name": "Tatooine")
    second_location = Location.create("location_name": "Death Star")
    person.locations << [first_location, second_location]
    expect(person.locations.first).to eq(first_location)
    expect(person.locations.second).to eq(second_location)
  end

  it "has no person related" do
    third_location = Location.create("location_name": "Naboo")
    expect(person.locations.third).not_to eq(third_location)
  end

end
