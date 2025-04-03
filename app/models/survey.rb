# frozen_string_literal: true

class Survey < ApplicationRecord
  validates :question, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :question, format: { with:  /\A[\w ?.,!']+\z/, message: 'must be a single sentence without line breaks' }

  has_many :responses, dependent: :destroy

  def total_responses
    responses.count
  end

  def yes_percentage
    return 0.0 if total_responses.zero?

    (responses.where(answer: true).count.to_f / total_responses * 100).round(2)
  end

  def no_percentage
    return 0.0 if total_responses.zero?

    (responses.where(answer: false).count.to_f / total_responses * 100).round(2)
  end
end
