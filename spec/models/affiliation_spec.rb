require 'rails_helper'

RSpec.describe Affiliation, type: :model do
  let(:person) {
    Person.create("first_name": "Darth", "last_name": "Vadar", "gender": "male", "species": "Human", "vehicle": "Tiefighter", "weapon": "lightsaber")
  }

  it "successfully relate to person" do
    first_affiliation = Affiliation.create("affiliation_name": "Sith")
    second_affiliation = Affiliation.create("affiliation_name": "Hutt Cartel")
    person.affiliations << [first_affiliation, second_affiliation]
    expect(person.affiliations.first).to eq(first_affiliation)
    expect(person.affiliations.second).to eq(second_affiliation)
  end

  it "has no person related" do
    third_affiliation = Affiliation.create("affiliation_name": "Rebels")
    expect(person.affiliations.third).not_to eq(third_affiliation)
  end
end
