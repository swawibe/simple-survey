# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Surveys', type: :request do
  let!(:survey) { Survey.create(question: 'Do you like coding?') }

  describe 'GET /surveys' do
    it 'returns a success response' do
      get surveys_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /surveys/:id' do
    it 'returns a success response' do
      get survey_path(survey)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'renders the new survey form' do
      # This simulates a GET request to the /surveys/new path
      get new_survey_path

      expect(response).to have_http_status(:ok)

      # Ensuring the response renders the 'new' template by checking the form present in the response body
      expect(response.body).to include('<form')

      # Making sure the rendered page has question field
      expect(response.body).to include('name="survey[question]"')
    end
  end

  describe 'POST /surveys' do
    context 'with valid parameters' do
      let(:valid_params) { { survey: { question: 'Are you a morning person?' } } }

      it 'creates a new survey' do
        expect do
          post surveys_path, params: valid_params
        end.to change(Survey, :count).by(1)
      end

      it 'redirects to the root path' do
        post surveys_path, params: valid_params
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { survey: { question: '' } } }

      it 'does not create a survey' do
        expect do
          post surveys_path, params: invalid_params
        end.not_to change(Survey, :count)
      end

      it 'renders the new template' do
        post surveys_path, params: invalid_params
        expect(response.body).to include('error') # Modify this based on your actual error rendering
      end
    end
  end
end
