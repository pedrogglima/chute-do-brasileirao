# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Team, type: :model) do
  let!(:team) { create :team }

  describe 'associations' do
    it { should have_many(:matches) }
    it { should have_many(:opponents) }
    it { should have_many(:next_opponents) }
    it { should have_many(:rankings) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(100) }
    it { should validate_presence_of(:state) }
    it { should validate_length_of(:state).is_at_least(1).is_at_most(2) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:avatar_url) }
  end

  describe 'attributes' do
    context 'with valid params' do
      it { expect(team).to(be_valid) }
    end
  end

  describe 'name' do
    subject { team }

    context 'when too long' do
      before { team.name = 'Name' * 100 }

      it { is_expected.to_not(be_valid) }
    end
  end

  describe 'state' do
    subject { team }

    context 'when too long' do
      before { team.state = 'SP' * 2 }

      it { is_expected.to_not(be_valid) }
    end
  end

  describe 'upload_avatar_from_url' do
    subject { team }

    context 'when avatar present' do
      let(:original_avatar_file) { FilesTestHelper.team_avatar_path }

      before do
        # the avatar_url must point to local file instead of a real url.
        team.avatar_url = original_avatar_file

        # We duplicate the file to conserve the original for repetitive testing
        # On the orignal code, the downloaded file is the one processed.
        copied_file = "tmp/test/downloads/#{SecureRandom.uuid}"
        FilesTestHelper.duplicate(original_avatar_file, copied_file)
        # We need to mock #on_tmp to download from local instead of from net
        expect(Download).to(
          receive(:on_tmp)
            .with(original_avatar_file)
            .and_return(copied_file)
        )

        team.name = 'Grêmio Paranaense' # checking that filename change
        team.avatar.purge # remove avatar before testing
        team.upload_avatar_from_url
      end

      let(:filename_after_upload) { 'avatar_gremio_paranaense' }
      let(:copied_file_size) { File.size(copied_file) }
      let(:file_size_before_image_process) { File.size(original_avatar_file) }
      let(:file_size_after_image_process) { 1360 }

      it { expect(team.avatar.attached?).to(be(true)) }
      it { expect(team.avatar.filename).to(eq(filename_after_upload)) }
      it { expect(file_size_before_image_process).to(eq(4377)) }
      it { expect(team.avatar.byte_size).to(eq(file_size_after_image_process)) }
    end
  end
end
