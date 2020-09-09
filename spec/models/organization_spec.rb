require 'rails_helper'

RSpec.describe Organization, type: :model do
  context 'validations' do
    it "is valid with a name and description" do
      organization = FactoryBot.build(:organization)
      expect(organization).to be_valid
    end

    it "is invalid without a first_name" do
      organization = FactoryBot.build(:organization, name: nil)
      organization.valid?

      expect(organization.errors[:name]).to include("can't be blank")
    end
  end

  context 'scopes' do
    context 'filter_by_name' do
      let!(:organization_1) { create :organization, name: 'test1' } 
      let!(:organization_2) { create :organization, name: 'test2' } 
      let!(:organization_3) { create :organization, name: 'TeSt3' } 

      it 'can accepts an empty string and return all' do
        results = Organization.filter_by_name('')
        expect(results).to include(organization_1)
        expect(results).to include(organization_2)
        expect(results).to include(organization_3)
      end

      it 'can accept a paritial string' do
        results = Organization.filter_by_name('st2')
        expect(results).to_not include(organization_1)
        expect(results).to include(organization_2)
        expect(results).to_not include(organization_3)
      end

      it 'can accept an uppercase string' do
        results = Organization.filter_by_name('st3')
        expect(results).to_not include(organization_1)
        expect(results).to_not include(organization_2)
        expect(results).to include(organization_3)
      end
    end
  end
end
