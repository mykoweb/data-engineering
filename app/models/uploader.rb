require 'csv'

class Uploader
  class << self
    def import(file)
      CSV.parse(file, headers: true, col_sep: "\t") do |line|
        return nil if any_missing_data_in? line

        purchaser = Purchaser.find_or_create_by(name: line['purchaser name'])
        merchant  = Merchant.where(name: line['merchant name']).first_or_create(name: line['merchant name'], address: line['merchant address'])
        item = Item.where(description: line['item description'], price: line['item price'], merchant_id: merchant.id).first_or_create
        Purchase.create(quantity: line['purchase count'], purchaser: purchaser, item: item)
      end
      return true
    end

    protected

      def any_missing_data_in?(line)
        return true unless line['purchaser name']
        return true unless line['merchant name']
        return true unless line['merchant address']
        return true unless line['item description']
        return true unless line['item price']
        return true unless line['purchase count']
        return nil
      end
  end
end
