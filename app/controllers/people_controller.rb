class PeopleController < ApplicationController
  require 'cgi'

  before_action :set_person, only: %i[ show update destroy ]


  # GET /people
  def index 
    raise 'You have not provided maximum record per page value. Please ensure this has been selected.' if params[:limit].blank?
    raise 'You have not provided a page value. Please ensure this has been selected.' if params[:offset].blank?
    #filtering
    if params[:filter_text].present?
      filter_text = "%#{params[:filter_text]}%"

      @people = Person.joins([:affiliations, :locations]).where("first_name LIKE ?", filter_text)
      .or(Person.where("last_name LIKE ?", filter_text))
      .or(Person.where("gender LIKE ?", filter_text))
      .or(Person.where("species LIKE ?", filter_text))
      .or(Person.where("vehicle LIKE ?", filter_text))
      .or(Person.where("weapon LIKE ?", filter_text))
      .or(Person.where("affiliation_name LIKE ?", filter_text))
      .or(Person.where("location_name LIKE ?", filter_text))
      .uniq
    else
      @people = Person.all
    end

    #build array
    people_array = Array.new
    @people.each do |person|
      people_array.push({"first_name" => person.first_name, "last_name" => person.last_name || "", "species" => person.species, "gender" => person.gender, "weapon" => person.weapon || "", "vehicle" => person.vehicle || "", 
      "affiliations" => person.convert_association_to_string("affiliation"), "locations" => person.convert_association_to_string("location")})
    end
    #sort the records
    people_array = eval("people_array.sort_by{|data| data['#{params[:sort_column]}']}") if params[:sort_direction] == 'asc'
    people_array = eval("people_array.sort_by{|data| data['#{params[:sort_column]}']}.reverse") if params[:sort_direction] == 'desc'
    #pagination
    if (is_integer(params[:limit]) and is_integer(params[:offset]))
      limit = params[:limit].to_i
      offset = limit * params[:offset].to_i
      people_array = people_array[offset, limit]
    end    
    render json: {"people" => people_array}
  end

  # # GET /people/1
  # def show
  #   render json: @person
  # end

  # # POST /people
  # def create
  #   @person = Person.new(person_params)

  #   if @person.save
  #     render json: @person, status: :created, location: @person
  #   else
  #     render json: @person.errors, status: :unprocessable_entity
  #   end
  # end

  # # PATCH/PUT /people/1
  # def update
  #   if @person.update(person_params)
  #     render json: @person
  #   else
  #     render json: @person.errors, status: :unprocessable_entity
  #   end
  # end

  # # DELETE /people/1
  # def destroy
  #   @person.destroy
  # end

  def import_person_csv
    require 'csv'
    uploaded_csv_file = File.open(params[:file])
    if uploaded_csv_file.present?
      CSV.parse(uploaded_csv_file, :headers => true, :quote_char => '"') do |csv_row|

        # If affiliation is present, import the row. If it isn't, continue without adding in
        if csv_row["Affiliations"].present?

          #titlize the name
          person_name = csv_row["Name"].to_s.titleize

          #split the name into first and last names
          split_name = person_name.split(' ', 2)
          first_name = split_name[0]
          (split_name.length > 1) ? last_name =split_name[1] : last_name = nil

          #create the new person
          new_person = Person.create!({first_name: first_name, last_name: last_name, species: csv_row["Species"], gender: csv_row["Gender"], weapon: csv_row["Weapon"], vehicle: csv_row["Vehicle"]})
          if new_person.save
            new_person.create_new_association('affiliation', csv_row)
            new_person.create_new_association('location', csv_row)
            
            # affiliation_values = row["Affiliations"].split(',')
            # affiliation_values.each do |affiliation_value|
            #   new_person.affiliations.create!({"affiliation_name" => affiliation_value.titleize})
            # end
            # location_values = row["Location"].split(',')
            # location_values.each do |location_value|
            #   new_person.locations.create!({"location_name" => location_value.titleize})
            # end            
          end
        end
      end
    else
      raise 'CSV file not found.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    

    # Only allow a list of trusted parameters through.
    def person_params
      params.require(:person).permit(:first_name, :last_name, :species, :gender, :weapon, :vehicle, affiliations_attributes: [:id, :affiliation_name])
    end
end
