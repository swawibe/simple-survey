# frozen_string_literal: true

class CreateResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :responses do |t|
      t.references :survey, null: false, foreign_key: true, index: true
      t.boolean :answer, null: false
      t.timestamps
    end

    add_index :responses, :answer
  end
end
