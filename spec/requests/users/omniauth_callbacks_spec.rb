# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Users::OmniauthCallbacksController, type: :request) do
  setup_omniauth do
    describe 'Post /omniauth_callback_twitter' do
      subject { post user_twitter_omniauth_callback_path }

      it 'should create user' do
        expect do
          subject
        end.to change { User.count }.by(1)
      end

      context 'after create' do
        it 'should redirect to' do
          expect(subject).to redirect_to(root_path)
        end
      end
    end

    describe 'Post /google_oauth2' do
      subject { post user_google_oauth2_omniauth_callback_path }

      it 'should create user' do
        expect do
          subject
        end.to change { User.count }.by(1)
      end

      context 'after create' do
        it 'should redirect to' do
          expect(subject).to redirect_to(root_path)
        end
      end
    end
  end
end
