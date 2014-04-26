class Story < ActiveRecord::Base
  validates :url, format: { with: URI.regexp }
  validates :description, :url, presence: true
end
