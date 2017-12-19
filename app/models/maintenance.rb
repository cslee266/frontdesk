class Maintenance < ApplicationRecord
	belongs_to :user
	enum status: [:submitted, :in_progress, :completed]
end
