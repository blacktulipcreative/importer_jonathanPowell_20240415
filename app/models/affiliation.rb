class Affiliation < ApplicationRecord
    belongs_to :person

    validates :person, :presence => true
    validates :affiliation_name, :presence => true

    before_save :generate_uuid

    private

    def generate_uuid
        #please note: only using this because using sqlite3 as the database.
        # Postgresql I would use gen_random_uuid() on the migration
        self.id = SecureRandom.uuid
    end

end
