# frozen_string_literal: true

# This migration comes from raif (originally 20250527213016)
class AddResponseIdAndResponseArrayToModelCompletions < ActiveRecord::Migration[7.1]
  def change
    json_column_type = if connection.adapter_name.downcase.include?("postgresql")
      :jsonb
    else
      :json
    end

    add_column :raif_model_completions, :response_id, :string
    add_column :raif_model_completions, :response_array, json_column_type
  end
end
