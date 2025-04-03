# frozen_string_literal: true

class ResponsesController < ApplicationController
  def create
    @survey = Survey.find(params[:survey_id])
    @response = @survey.responses.build(answer: params[:answer])
    if @response.save
      redirect_to surveys_path(page: params[:page]), notice: 'Response submitted.'
    else
      redirect_to surveys_path(page: params[:page]), alert: 'Error saving response.'
    end
  end
end
