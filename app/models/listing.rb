class Listing < ApplicationRecord
  belongs_to :user
  validates :title, :description, :qty, :price, presence: true
  validates :qty, :price, numericality: true
end
