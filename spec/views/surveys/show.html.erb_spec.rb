# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'surveys/show', type: :view do
  before do
    @survey = Survey.create(question: 'Do you like coding?')
    assign(:survey, @survey)
  end

  it 'displays the survey question' do
    render
    expect(rendered).to match(/Do you like coding?/)
  end

  it 'has Yes and No buttons' do
    render
    expect(rendered).to include('<button', 'Yes')
    expect(rendered).to include('<button', 'No')
  end

  it 'has current responses' do
    render
    expect(rendered).to include('<span', 'Yes')
    expect(rendered).to include('<span', 'No')
    expect(rendered).to include('<span', 'Total')
  end
end
