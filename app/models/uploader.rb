require 'csv'

class Uploader
  class << self
    def import(file)
      CSV.parse(file, headers: true, col_sep: "\t") do |line|
        purchaser = Purchaser.find_or_create_by(name: line['purchaser name'])
        merchant  = Merchant.where(name: line['merchant name']).first_or_create(name: line['merchant name'], address: line['merchant address'])
        item = Item.where(description: line['item description'], price: line['item price'], merchant_id: merchant.id).first_or_create
        Purchase.create(quantity: line['purchase count'], purchaser: purchaser, item: item)
      end
    end
  end
end
