class Person < ApplicationRecord

    has_many :affiliations
    has_many :locations

    accepts_nested_attributes_for :affiliations
    accepts_nested_attributes_for :locations

    #validations

    validates :first_name, :presence => true
    validates :species, :presence => true#, inclusion: {in: species.values}
    validates :gender, :presence => true#, inclusion: {in: gender.values}

    before_validation :update_gender
    before_save :generate_uuid

    def update_gender
        if self.gender.upcase == 'M'
            self.gender = "Male"
        elsif self.gender.upcase == 'F'
            self.gender = "Female"
        end
    end

    # association_type = String - 'affiliation' or 'location'

    def create_new_association(association_type='affiliation', csv_row=nil)
        # if affiliation, change to Affiliations. If location, change to Location
        association_type == 'affiliation' ?  association_split_value = association_type.pluralize.titleize : association_split_value = association_type.titleize
        # split up the array
        if csv_row.present?
          association_values = eval("csv_row['#{association_split_value}'].split(',')")
          # create a record for each item
          association_values.each do |association_value|
            eval("self.#{association_type.pluralize}.create!({'#{association_type}_name' => association_value.titleize})")
          end
        else
            self.errors.add(:base, "CSV row does not exist")
        end
    end

     # association_type = String - 'affiliation' or 'location'

    def convert_association_to_string(association_type)
        return_string = eval("self.#{association_type.pluralize}.map { |association| association.#{association_type}_name }.join(', ')")
        return return_string
    end

    private

    def generate_uuid
        #please note: only using this because using sqlite3 as the database.
        # Postgresql I would use gen_random_uuid() on the migration
        self.id = SecureRandom.uuid
    end

end
