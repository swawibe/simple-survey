# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Responses', type: :request do
  let!(:survey) { Survey.create!(question: 'Are you a morning person?') }

  describe 'POST /surveys/:survey_id/responses' do
    context 'when the response is valid' do
      it 'creates a response and redirects to surveys path' do
        post survey_responses_path(survey), params: { answer: true, page: 1 }

        expect(Response.count).to eq(1)
        expect(response).to redirect_to(surveys_path(page: 1))

        # Verify flash notice
        follow_redirect!
        expect(flash[:notice]).to eq('Response submitted.')
      end
    end

    context 'when the response is invalid' do
      it 'does not create a response and redirects with an error' do
        # Simulate sending an invalid answer (nil or invalid answer)
        post survey_responses_path(survey), params: { answer: nil, page: 1 }

        # Verify no response is created
        expect(Response.count).to eq(0)

        # Verify redirection with alert message
        expect(response).to redirect_to(surveys_path(page: 1))

        # Verify flash alert
        follow_redirect!
        expect(flash[:alert]).to eq('Error saving response.')
      end
    end
  end
end
