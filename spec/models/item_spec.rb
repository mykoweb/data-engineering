require 'spec_helper'

describe Item do
  context 'with valid data' do
    let(:item) { Item.create(description: 'Lorem ipsum', price: 9.99) }

    subject { item }

    it { should be_valid }
  end

  context 'with no description' do
    let(:item) { Item.create(price: 20.01) }

    subject { item }

    it { should_not be_valid }
  end

  context 'with no price' do
    let(:item) { Item.create(description: 'Foobar foobar') }

    subject { item }

    it { should_not be_valid }
  end

  describe 'associations' do
    context 'with :purchases' do
      let(:association) { Item.reflect_on_association(:purchases) }

      subject { association }

      it 'should be has_many' do
        expect(association.macro).to equal(:has_many)
      end
    end

    context 'with :merchant' do
      let(:association) { Item.reflect_on_association(:merchant) }

      subject { association }

      it 'should be belongs_to' do
        expect(association.macro).to equal(:belongs_to)
      end
    end
  end
end
