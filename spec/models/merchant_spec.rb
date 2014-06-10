require 'spec_helper'

describe Merchant do
  context 'with valid data' do
    let(:merchant) do
      Merchant.create(
        name: 'Joe Smith Hardware',
        address: "123 Main Street, San Francisco CA, 95555")
    end

    subject { merchant }

    it { should be_valid }
  end

  context 'with no name' do
    let(:merchant) { Merchant.create(address: '123 Main Street') }

    subject { merchant }

    it { should_not be_valid }
  end

  context 'with no address' do
    let(:merchant) { Merchant.create(name: 'Bob Smith Motorworks') }

    subject { merchant }

    it { should_not be_valid }
  end

  describe 'associations' do
    let(:association) { Merchant.reflect_on_association(:items) }

    subject { association }

    it 'should have many items' do
      expect(association.macro).to equal(:has_many)
    end
  end
end
