# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

survey_questions = [
  'Are you a morning person?',
  'Do you like to be around people?',
  'Do you enjoy working from home?',
  'Have you ever traveled abroad?',
  'Do you like spicy food?',
  'Do you prefer coffee over tea?',
  'Is fitness a part of your daily routine?',
  'Do you like to watch movies in theaters?',
  'Do you enjoy reading books?',
  'Have you ever been skydiving?',
  'Is learning a new language on your bucket list?',
  'Do you prefer city life over countryside?',
  'Are you an early riser?',
  'Do you enjoy listening to music while working?',
  'Do you believe in astrology?'
]

survey_questions.each do |question|
  Survey.find_or_create_by(question: question)
end
