# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Response, type: :model do
  describe 'validations' do
    before do
      @survey = Survey.create(question: 'Are you a morning person?')
    end

    it 'is valid with an answer of true or false' do
      response1 = @survey.responses.create!(answer: true)
      response2 = @survey.responses.create!(answer: false)

      expect(response1).to be_valid
      expect(response2).to be_valid
    end

    it 'is invalid with an answer other than true or false' do
      response = @survey.responses.new(answer: nil)

      expect(response).not_to be_valid
      expect(response.errors[:answer]).to include('is not included in the list')
    end
  end

  describe 'associations' do
    it 'belongs to a survey' do
      survey = Survey.create!(question: 'Are you a morning person?')
      response = Response.create!(survey: survey, answer: true)

      expect(response.survey).to eq(survey)
    end
  end
end
