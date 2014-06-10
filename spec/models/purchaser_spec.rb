require 'spec_helper'

describe Purchaser do
  context 'with valid name' do
    let(:purchaser) { Purchaser.create(name: 'Axel Rose') }

    subject { purchaser }

    it { should be_valid }
  end

  context 'with invalid name' do
    let(:purchaser) { Purchaser.create(name: '') }

    subject { purchaser }

    it { should_not be_valid }
  end

  describe 'associations' do
    let(:association) { Purchaser.reflect_on_association(:purchases) }

    subject { association }

    it 'should have many purchases' do
      expect(association.macro).to equal(:has_many)
    end
  end
end
