# frozen_string_literal: true

class Response < ApplicationRecord
  validates :answer, inclusion: { in: [true, false] }

  belongs_to :survey
end
