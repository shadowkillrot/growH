require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has many habits' do
      association = User.reflect_on_association(:habits)
      expect(association.macro).to eq :has_many
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(email: 'test@example.com', password: 'password123')
      expect(user).to be_valid
    end

    it 'is not valid without email' do
      user = User.new(password: 'password123')
      expect(user).to_not be_valid
    end
  end
end