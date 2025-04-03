# frozen_string_literal: true

class CreateSurveys < ActiveRecord::Migration[7.1]
  def change
    create_table :surveys do |t|
      t.string :question
      t.timestamps
    end
    add_index :surveys, :question, unique: true
  end
end
