class ContestEntry < ApplicationRecord
  scope :entries_for, ->(report_range) { where(created_at: report_range) }

  class << self
    def create_for(user)
      where(user_id: user.id, created_at: Date.current.all_day).first_or_create do |entry|
        entry.user_id = user.id
        entry.first_name = user.first_name
        entry.last_name = user.last_name
        entry.email = user.email
      end
    end

    def to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |entry|
          csv << entry.attributes.values_at(*column_names)
        end
      end
    end
  end
end
