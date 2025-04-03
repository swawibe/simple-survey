# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'surveys/index', type: :view do
  let!(:survey_1) { Survey.create!(question: 'Are you a morning person?') }
  let!(:survey_2) { Survey.create!(question: 'Do you like to be around people?') }

  before do
    # Mocking paginated surveys
    @surveys = Survey.paginate(page: 1, per_page: 10)
    assign(:surveys, @surveys)
  end

  it 'renders the surveys table with survey questions' do
    render

    # Check if the page contains the survey questions
    expect(rendered).to include(survey_1.question)
    expect(rendered).to include(survey_2.question)
  end

  it 'displays the yes percentage for each survey' do
    render

    # Check if each survey's yes percentage is displayed in a badge
    expect(rendered).to include("#{survey_1.yes_percentage}%")
    expect(rendered).to include("#{survey_2.yes_percentage}%")
  end

  it 'displays the no percentage for each survey' do
    render

    # Check if each survey's no percentage is displayed in a badge
    expect(rendered).to include("#{survey_1.no_percentage}%")
    expect(rendered).to include("#{survey_2.no_percentage}%")
  end

  it 'displays the total responses count for each survey' do
    render

    # Check if each survey's total responses count is displayed
    expect(rendered).to include(survey_1.total_responses.to_s)
    expect(rendered).to include(survey_2.total_responses.to_s)
  end

  it 'renders the pagination controls when there are multiple pages' do
    # Simulate that there are multiple pages of surveys
    allow(@surveys).to receive(:total_pages).and_return(2)
    render

    # Check if the pagination controls are included
    expect(rendered).to include('Previous')
    expect(rendered).to include('Next')
  end

  it 'does not render pagination controls if there is only one page' do
    # Simulate that there is only one page of surveys
    allow(@surveys).to receive(:total_pages).and_return(1)
    render

    # Ensure pagination is not included when there is only one page
    expect(rendered).not_to include('Previous')
    expect(rendered).not_to include('Next')
  end

  it 'renders the "New Survey" button' do
    render

    # Check if the "New Survey" button is included in the rendered HTML
    expect(rendered).to include('New Survey')
  end

  it 'renders the View button for each survey' do
    render

    # Check if a "View" button exists for each survey
    expect(rendered).to include('View')
  end
end
