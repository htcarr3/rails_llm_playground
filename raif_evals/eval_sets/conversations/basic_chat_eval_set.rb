module Raif
  module Evals
    module Conversations
      class BasicChatEvalSet < Raif::Evals::EvalSet
        # Run this eval set with:
        # bundle exec raif evals ./raif_evals/eval_sets/conversations/basic_chat_eval_set.rb

        # Setup method runs before each eval
        setup do
          # Common setup code
          # @user = User.create!(email: "test@example.com")
          # @conversation = Raif::Conversations::BasicChat.create!(creator: @user)
        end

        # Teardown runs after each eval
        teardown do
          # Cleanup code
        end

        eval "BasicChat responds appropriately to user greeting" do
          # entry = @conversation.entries.create!(
          #   user_message: "Hello, how are you?",
          #   creator: @user
          # )

          # entry.process_entry!

          # expect "generates a response" do
          #   entry.model_response_message.present?
          # end

          # expect "response is friendly" do
          #   entry.model_response_message.match?(/hello|hi|greetings/i)
          # end
        end

        eval "BasicChat maintains conversation context" do
          # First message establishes context
          # first_entry = @conversation.entries.create!(
          #   user_message: "My name is Alice",
          #   creator: @user
          # )
          # first_entry.process_entry!

          # Second message references context
          # second_entry = @conversation.entries.create!(
          #   user_message: "What's my name?",
          #   creator: @user
          # )
          # second_entry.process_entry!

          # expect "remembers the user's name" do
          #   second_entry.model_response_message.include?("Alice")
          # end
        end

        eval "BasicChat handles tool invocations correctly" do
          # Test if your conversation uses tools
          # @conversation.update!(available_model_tools: [ "Raif::ModelTools::FetchUrl" ])

          # entry = @conversation.entries.create!(
          #   user_message: "What can you tell me about the content of https://en.wikipedia.org/wiki/Moon",
          #   creator: @user
          # )

          # entry.process_entry!

          # expect_tool_invocation(entry, "Raif::ModelTools::FetchUrl", with: { url: "https://en.wikipedia.org/wiki/Moon" })
        end
      end
    end
  end
end
