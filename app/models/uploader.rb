require 'csv'

class Uploader
  class << self
    def import_and_calculate_gross(file)
      gross_revenue = 0

      CSV.parse(file, headers: true, col_sep: "\t") do |line|
        return nil if any_missing_data_in? line
        return nil if any_incorrect_data_in? line

        gross_revenue += line['item price'].to_d * line['purchase count'].to_i

        purchaser = Purchaser.find_or_create_by(name: line['purchaser name'])
        merchant  = Merchant.where(
                      name: line['merchant name']
                    ).first_or_create(
                      name: line['merchant name'],
                      address: line['merchant address']
                    )
        # find_by queries using SQLite don't seem to handle
        # special characters such as "$" correctly. Using
        # the where method instead. I'm going to assume special
        # characters are not being used for the other
        # objects, but they probably need to be updated
        # as well if SQLite is going to be used.
        item = Item.where(
                 "description LIKE ? AND price = ? AND merchant_id = ?",
                 line['item description'], line['item price'], merchant.id
               ).first_or_create(
                 description: line['item description'],
                 price: line['item price'],
                 merchant_id: merchant.id
               )
        Purchase.create(quantity: line['purchase count'], purchaser: purchaser, item: item)
      end
      return gross_revenue
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

      # TODO: We need to add more validations either here or in the models
      def any_incorrect_data_in?(line)
        # Verify line['purchase count'] is an Integer
        return true unless line['purchase count'].to_i.to_s == line['purchase count']
        return nil
      end
  end
end
