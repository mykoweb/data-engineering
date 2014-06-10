require 'spec_helper'

describe 'Uploader pages' do

  describe 'on initial visit' do
    before { visit new_uploader_path }

    subject { page }

    it { should have_selector('h1', text: 'Living Social Coding Challenge') }
    it { should have_selector('h3', text: 'Import a tab-delimited file') }
    it { should have_button('Import File') }
  end

  describe 'when uploading with no file' do
    let(:purchasers) { Purchaser.all }
    let(:items)      { Item.all }

    before do
      visit new_uploader_path
      click_button('Import File')
    end

    it 'should have the correct error message' do
      expect(page).to have_selector('div', text: 'You need to choose a file')
    end

    it "shouldn't have any purchasers" do
      expect(purchasers).to be_empty
    end

    it "shouldn't have any items" do
      expect(items).to be_empty
    end
  end

  describe 'when uploading valid file' do
    let(:purchasers) { Purchaser.all }
    let(:items)      { Item.all }
    let(:merchants)  { Merchant.all }
    let(:purchases)  { Purchase.all }
    let(:amy_pond)   { Purchaser.find_by(name: 'Amy Pond') }
    let(:sneakers)   { Merchant.find_by(name: 'Sneaker Store Emporium').items }

    before do
      visit new_uploader_path
      file_path = Rails.root + 'example_input.tab'
      attach_file('file', file_path)
      click_button('Import File')
    end

    it 'should have the correct flash message' do
      expect(page).to have_selector('div', text: 'File successfully imported')
    end

    it 'should have the correct link' do
      expect(page).to have_selector('a', text: 'Upload another file')
    end

    it 'should have 3 purchasers' do
      expect(purchasers.count).to equal(3)
    end

    it 'should have 3 merchants' do
      expect(merchants.count).to equal(3)
    end

    it 'should have 5 purchases for purchaser Amy Pond' do
      expect(amy_pond.purchases.first.quantity).to equal(5)
    end

    it 'should have 5 total purchases for sneakers' do
      expect(sneakers.inject(0) { |sum, p| p.purchases.first.quantity+sum }).to equal(5)
    end
  end
end
