# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let(:teacher) { create(:teacher) }
  let(:another_user) { create(:teacher) }
  let(:valid_session) { { user_id: teacher.id } }

  describe '#current_user' do
    it 'returns user for valid session user_id' do
      allow(helper).to receive(:session).and_return(valid_session)
      expect(helper.current_user.id).to eq teacher.id
    end
    it 'returns null for invalid session user_id' do
      invalid_session = valid_session
      invalid_session[:user_id] = 12
      allow(helper).to receive(:session).and_return(invalid_session)
      expect(helper.current_user).to eq nil
    end
    it 'returns null for missing session user_id' do
      empty_session = valid_session
      empty_session[:user_id] = nil
      allow(helper).to receive(:session).and_return(valid_session)
      expect(helper.current_user).to eq nil
    end
  end
end
