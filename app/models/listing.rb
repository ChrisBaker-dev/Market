class Listing < ApplicationRecord
  belongs_to :user
  validates :title, :description, :qty, :price, presence: true
  validates :qty, :price, numericality: true

  has_one_attached :image
  has_many :orders
end
