# frozen_string_literal: true

class SurveysController < ApplicationController
  PAGE_SIZE = 20
  def index
    @surveys = Survey.includes(:responses).paginate(page: params[:page], per_page: PAGE_SIZE)
  end

  def show
    @survey = Survey.find(params[:id])
    @responses = @survey.responses
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)
    if @survey.save
      redirect_to root_path, notice: 'Survey created successfully.'
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def survey_params
    params.require(:survey).permit(:question)
  end
end
