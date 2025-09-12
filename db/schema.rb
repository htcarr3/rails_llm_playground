# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_09_12_125246) do
  create_table "chats", force: :cascade do |t|
    t.string "model_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_chats_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "chat_id", null: false
    t.string "role"
    t.text "content"
    t.string "model_id"
    t.integer "input_tokens"
    t.integer "output_tokens"
    t.integer "tool_call_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["tool_call_id"], name: "index_messages_on_tool_call_id"
  end

  create_table "raif_agents", force: :cascade do |t|
    t.string "type", null: false
    t.string "llm_model_key", null: false
    t.text "task"
    t.text "system_prompt"
    t.text "final_answer"
    t.integer "max_iterations", default: 10, null: false
    t.integer "iteration_count", default: 0, null: false
    t.json "available_model_tools", null: false
    t.string "creator_type", null: false
    t.integer "creator_id", null: false
    t.string "requested_language_key"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "failed_at"
    t.text "failure_reason"
    t.json "conversation_history", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_raif_agents_on_created_at"
    t.index ["creator_type", "creator_id"], name: "index_raif_agents_on_creator"
  end

  create_table "raif_conversation_entries", force: :cascade do |t|
    t.integer "raif_conversation_id", null: false
    t.string "creator_type", null: false
    t.integer "creator_id", null: false
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "failed_at"
    t.text "user_message"
    t.text "raw_response"
    t.text "model_response_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_raif_conversation_entries_on_created_at"
    t.index ["creator_type", "creator_id"], name: "index_raif_conversation_entries_on_creator"
    t.index ["raif_conversation_id"], name: "index_raif_conversation_entries_on_raif_conversation_id"
  end

  create_table "raif_conversations", force: :cascade do |t|
    t.string "llm_model_key", null: false
    t.string "creator_type", null: false
    t.integer "creator_id", null: false
    t.string "requested_language_key"
    t.string "type", null: false
    t.text "system_prompt"
    t.json "available_model_tools", null: false
    t.json "available_user_tools", null: false
    t.integer "conversation_entries_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "response_format", default: 0, null: false
    t.index ["created_at"], name: "index_raif_conversations_on_created_at"
    t.index ["creator_type", "creator_id"], name: "index_raif_conversations_on_creator"
  end

  create_table "raif_model_completions", force: :cascade do |t|
    t.string "source_type"
    t.integer "source_id"
    t.string "llm_model_key", null: false
    t.string "model_api_name", null: false
    t.json "available_model_tools", null: false
    t.json "messages", null: false
    t.text "system_prompt"
    t.integer "response_format", default: 0, null: false
    t.string "response_format_parameter"
    t.decimal "temperature", precision: 5, scale: 3
    t.integer "max_completion_tokens"
    t.integer "completion_tokens"
    t.integer "prompt_tokens"
    t.text "raw_response"
    t.json "response_tool_calls"
    t.integer "total_tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "prompt_token_cost", precision: 10, scale: 6
    t.decimal "output_token_cost", precision: 10, scale: 6
    t.decimal "total_cost", precision: 10, scale: 6
    t.integer "retry_count", default: 0, null: false
    t.string "response_id"
    t.json "response_array"
    t.json "citations"
    t.boolean "stream_response", default: false, null: false
    t.index ["created_at"], name: "index_raif_model_completions_on_created_at"
    t.index ["source_type", "source_id"], name: "index_raif_model_completions_on_source"
  end

  create_table "raif_model_tool_invocations", force: :cascade do |t|
    t.string "source_type", null: false
    t.integer "source_id", null: false
    t.string "tool_type", null: false
    t.json "tool_arguments", null: false
    t.json "result", null: false
    t.datetime "completed_at"
    t.datetime "failed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_type", "source_id"], name: "index_raif_model_tool_invocations_on_source"
  end

  create_table "raif_tasks", force: :cascade do |t|
    t.string "type", null: false
    t.text "prompt"
    t.text "raw_response"
    t.string "creator_type"
    t.integer "creator_id"
    t.text "system_prompt"
    t.string "requested_language_key"
    t.integer "response_format", default: 0, null: false
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "failed_at"
    t.json "available_model_tools", null: false
    t.string "llm_model_key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "task_run_args"
    t.index ["completed_at"], name: "index_raif_tasks_on_completed_at"
    t.index ["created_at"], name: "index_raif_tasks_on_created_at"
    t.index ["creator_type", "creator_id"], name: "index_raif_tasks_on_creator"
    t.index ["failed_at"], name: "index_raif_tasks_on_failed_at"
    t.index ["started_at"], name: "index_raif_tasks_on_started_at"
    t.index ["type", "completed_at"], name: "index_raif_tasks_on_type_and_completed_at"
    t.index ["type", "failed_at"], name: "index_raif_tasks_on_type_and_failed_at"
    t.index ["type", "started_at"], name: "index_raif_tasks_on_type_and_started_at"
    t.index ["type"], name: "index_raif_tasks_on_type"
  end

  create_table "raif_user_tool_invocations", force: :cascade do |t|
    t.integer "raif_conversation_entry_id", null: false
    t.string "type", null: false
    t.json "tool_settings", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["raif_conversation_entry_id"], name: "index_raif_user_tool_invocations_on_raif_conversation_entry_id"
  end

  create_table "raix_chats", force: :cascade do |t|
    t.string "model_id"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_raix_chats_on_user_id"
  end

  create_table "raix_messages", force: :cascade do |t|
    t.integer "raix_chat_id", null: false
    t.string "model_id"
    t.string "role"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["raix_chat_id"], name: "index_raix_messages_on_raix_chat_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "tool_calls", force: :cascade do |t|
    t.integer "message_id", null: false
    t.string "tool_call_id", null: false
    t.string "name", null: false
    t.json "arguments", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_tool_calls_on_message_id"
    t.index ["tool_call_id"], name: "index_tool_calls_on_tool_call_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "chats", "users"
  add_foreign_key "messages", "chats"
  add_foreign_key "raif_conversation_entries", "raif_conversations"
  add_foreign_key "raif_user_tool_invocations", "raif_conversation_entries"
  add_foreign_key "raix_chats", "users"
  add_foreign_key "raix_messages", "raix_chats"
  add_foreign_key "sessions", "users"
  add_foreign_key "tool_calls", "messages"
end
