# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Survey, type: :model do
  describe 'validations' do
    context 'when question format is valid' do
      it 'is valid with a question' do
        survey = Survey.new(question: 'Are you a morning person?')
        expect(survey).to be_valid
      end

      it 'allows punctuation marks' do
        survey = Survey.new(question: 'Hello, world!')
        expect(survey).to be_valid
      end
    end

    context 'when question format is invalid' do
      it 'does not allow newlines' do
        survey = Survey.new(question: "This is the first line.\nThis is the second line.")
        expect(survey).to be_invalid
        expect(survey.errors[:question]).to include('must be a single sentence without line breaks')
      end

      it 'does not allow special characters other than specified' do
        survey = Survey.new(question: "Invalid characters: @\#$%^&*()")
        expect(survey).to be_invalid
        expect(survey.errors[:question]).to include('must be a single sentence without line breaks')
      end

      it 'does not allow empty question' do
        survey = Survey.new(question: '')
        expect(survey).to be_invalid
        expect(survey.errors[:question]).to include('must be a single sentence without line breaks')
      end

      it 'is invalid without a question' do
        survey = Survey.new(question: nil)
        expect(survey).to be_invalid
        expect(survey.errors[:question]).to include("can't be blank")
      end

      it 'is invalid with a question longer than 100 characters' do
        survey = Survey.new(question: 'Q' * 101)
        expect(survey).to be_invalid
        expect(survey.errors[:question]).to include('is too long (maximum is 100 characters)')
      end

      it 'is invalid with a duplicate question' do
        Survey.create!(question: 'Do you like pizza?')
        survey = Survey.new(question: 'Do you like pizza?')
        expect(survey).to be_invalid
        expect(survey.errors[:question]).to include('has already been taken')
      end
    end
  end

  describe 'associations' do
    it 'has many responses' do
      survey = Survey.create!(question: 'Are you a morning person?')
      response1 = Response.create!(survey: survey, answer: true)
      response2 = Response.create!(survey: survey, answer: false)

      expect(survey.responses).to include(response1, response2)
    end
  end

  describe 'instance methods' do
    let!(:survey) { Survey.create!(question: 'Are you a morning person?') }

    before do
      survey.responses.create!(answer: true)
      survey.responses.create!(answer: false)
      survey.responses.create!(answer: true)
    end

    describe '#total_responses' do
      it 'returns the total number of responses' do
        expect(survey.total_responses).to eq(3)
      end
    end

    describe '#yes_percentage' do
      it 'returns the percentage of "yes" answers' do
        expect(survey.yes_percentage).to eq(66.67)
      end

      it 'returns 0.0 when there are no responses' do
        empty_survey = Survey.create!(question: 'Do you like pizza?')
        expect(empty_survey.yes_percentage).to eq(0.0)
      end
    end

    describe '#no_percentage' do
      it 'returns the percentage of "no" answers' do
        expect(survey.no_percentage).to eq(33.33)
      end

      it 'returns 0.0 when there are no responses' do
        empty_survey = Survey.create!(question: 'Do you like pizza?')
        expect(empty_survey.no_percentage).to eq(0.0)
      end
    end
  end
end
