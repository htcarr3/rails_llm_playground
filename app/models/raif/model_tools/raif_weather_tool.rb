module Raif
  module ModelTools
    class RaifWeatherTool < Raif::ModelTool
      # For example tool implementations, see:
      # Wikipedia Search Tool: https://github.com/CultivateLabs/raif/blob/main/app/models/raif/model_tools/wikipedia_search.rb
      # Fetch URL Tool: https://github.com/CultivateLabs/raif/blob/main/app/models/raif/model_tools/fetch_url.rb

      tool_description do
        "Get the weather for a given location using its latitude and longitude"
      end

      # Define the schema for the arguments that the LLM should use when invoking your tool.
      # It should be a valid JSON schema. When the model invokes your tool,
      # the arguments it provides will be validated against this schema using JSON::Validator from the json-schema gem.
      #
      # All attributes will be required and additionalProperties will be set to false.
      #
      # See https://docs.raif.ai/learn_more/json_schemas for more information about defining JSON schemas.
      tool_arguments_schema do
        string :latitude, description: "Latitude (e.g., 52.5200)"
        string :longitude, description: "Longitude (e.g., 52.5200)"

        #
        # object :widget, description: "A widget's description" do
        #   boolean :is_red, description: "Whether the widget is red"
        #   integer :rating, description: "A rating of the widget from 1 to 10", minimum: 1, maximum: 10
        #   array :tags, description: "Associated tags" do
        #     items type: "string"
        #   end
        # end
        #
        # array :products, description: "List of products" do
        #   object do
        #     integer :id, description: "Product identifier"
        #     string :name, description: "Product name"
        #     number :price, description: "Product price", minimum: 0
        #   end
        # end
      end

      # An example of how the LLM should invoke your tool. This should return a hash with name and arguments keys.
      # `to_json` will be called on it and provided to the LLM as an example of how to invoke your tool.
      example_model_invocation do
        {
          "name": tool_name,
          "arguments": {}
        }
      end

      class << self
        # When your tool is invoked by the LLM in a Raif::Agent loop,
        # the results of the tool invocation are provided back to the LLM as an observation.
        # This method should return whatever you want provided to the LLM.
        # For example, if you were implementing a GoogleSearch tool, this might return a JSON
        # object containing search results for the query.
        def observation_for_invocation(tool_invocation)
          return "No results found" unless tool_invocation.result.present?

          JSON.pretty_generate(tool_invocation.result)
        end

        # When your tool is invoked in a Raif::Conversation, should the result be automatically provided back to the model?
        # When true, observation_for_invocation will be used to produce the observation provided to the model
        def triggers_observation_to_model?
          false
        end

        # When the LLM invokes your tool, this method will be called with a `Raif::ModelToolInvocation` record as an argument.
        # It should handle the actual execution of the tool.
        # For example, if you are implementing a GoogleSearch tool, this method should run the actual search
        # and store the results in the tool_invocation's result JSON column.
        def process_invocation(tool_invocation)
          # Extract arguments from tool_invocation.tool_arguments
          latitude = tool_invocation.tool_arguments["latitude"]
          longitude = tool_invocation.tool_arguments["longitude"]
          # Process the invocation and perform the desired action
          begin
            url = "https://api.open-meteo.com/v1/forecast?temperature_unit=fahrenheit&latitude=#{latitude}&longitude=#{longitude}&current=temperature_2m,wind_speed_10m"

            response = Faraday.get(url)
            result = JSON.parse(response.body)
          rescue => e
            result = { error: e.message }
          end

          # Store the results in the tool_invocation
          tool_invocation.update!(
            result: result
          )
          # Return the result
          tool_invocation.result
        end
      end
    end
  end
end
