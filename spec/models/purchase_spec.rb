require 'spec_helper'

describe Purchase do
  context 'with valid quantity' do
    let(:purchase) { Purchase.create(quantity: 5) }

    subject { purchase }

    it { should be_valid }

    it 'should equal 5' do
      expect(purchase.quantity).to equal(5)
    end
  end

  context 'with no quantity' do
    let(:purchase) { Purchase.create }
    
    subject { purchase }

    it { should_not be_valid }
  end

  describe 'associations' do
    context 'with :purchasers' do
      let(:association) { Purchase.reflect_on_association(:purchaser) }

      subject { association }

      it 'should be belongs_to' do
        expect(association.macro).to equal(:belongs_to)
      end
    end

    context 'with :items' do
      let(:association) { Purchase.reflect_on_association(:item) }

      subject { association }

      it 'should be belongs_to' do
        expect(association.macro).to equal(:belongs_to)
      end
    end
  end
end
