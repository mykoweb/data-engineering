class Item < ActiveRecord::Base
  has_many :purchases
  has_many :purchasers, through: :purchases
  belongs_to :merchant
  
  validates :description, presence: true
  validates :price, presence: true
end
