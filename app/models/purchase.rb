class Purchase < ActiveRecord::Base
  belongs_to :purchaser
  belongs_to :item

  validates :quantity, presence: true
end
