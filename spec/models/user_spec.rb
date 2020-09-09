require 'rails_helper'

RSpec.describe User, type: :model do
  context 'relationships' do
    it { should have_many(:organizations).through(:memberships) }
  end

  it "is valid with a first_name, last_name, email and password" do
    user = User.new(first_name: "Robo", last_name: "Tron", email: "robotron@dundermifflin.com", password: "password", password_confirmation: "password")
    expect(user).to be_valid
  end

  it "is invalid without a first_name" do
    user = FactoryBot.build(:user, first_name: nil)
    user.valid?

    expect(user.errors[:first_name]).to include("can't be blank")
  end
  
  it "is invalid without a last_name" do
    user = FactoryBot.build(:user, last_name: nil)
    user.valid?

    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid without a email" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?

    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid with a duplicate email" do
    FactoryBot.create(:user, email: "robotron@dundermifflin.com")
    user = FactoryBot.build(:user, email: "robotron@dundermifflin.com")

    user.valid?

    expect(user.errors[:email]).to include("has already been taken")
  end
end
