# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(User, type: :model) do
  let!(:user) { create :user }

  describe 'associations' do
    it { should have_many(:bets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'attributes' do
    context 'with valid params' do
      it { expect(user).to(be_valid) }
    end
  end

  describe 'email' do
    subject { user }

    context 'with valid address' do
      it { is_expected.to(be_valid) }
    end

    context 'with invalid address' do
      before { user.email = 'invalid_example' }

      it { is_expected.to_not(be_valid) }
    end

    context 'with empty address' do
      before { user.email = nil }

      it { is_expected.to_not(be_valid) }
    end
  end

  describe 'first and last name' do
    subject { user }

    context 'when empty' do
      before do
        user.first_name = nil
        user.last_name = nil
      end

      it { is_expected.to_not(be_valid) }
    end

    context 'when too long' do
      before { user.first_name = 'Name' * 100 }

      it { is_expected.to_not(be_valid) }
    end
  end

  describe 'password' do
    subject { user.valid_password?(user.password) }

    context 'when is correct' do
      it { is_expected.to(be_truthy) }
    end

    context 'when is empty' do
      before { user.password = '' }

      it { is_expected.to(be_falsey) }
    end

    context 'when is incorrect' do
      it { expect(user.valid_password?(user.encrypted_password.upcase)).to(be_falsey) }
    end
  end
end
