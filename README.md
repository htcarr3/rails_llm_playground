# Rails LLM Playground

A Rails application for exploring and testing different Large Language Model (LLM) integrations and frameworks. This playground is meant to showcase how to build similar features across different gems.

## Features

### 🤖 Multiple LLM Integration Approaches

1. **RubyLLM Integration** - Direct integration with the `ruby_llm` gem
   - Standard chat interface with model selection
   - Asynchronous message processing
   - Tool integration support

2. **Raix Integration** - Example implementation of the `raix` gem
   - Standard chat interface
   - Asynchronous message processing
   - Tool integration support
   - Structured workflow

3. **Raif Engine** - Mounted engine for convention-over-configuration approach to LLM integration
   - Standard chat interface with model selection
   - Asynchronous message processing
   - Tool integration support

### 🔧 Core Features

- **Basic Auth** - Simple Rails-generated authentication
- **Real-time Updates** - Turbo-powered real-time message updates

### 🎯 LLM Providers Support

- OpenAI
- Additional providers can be added, see gem documentation for details

## Technology Stack

- **Framework**: Ruby on Rails 8.0+
- **Database**: SQLite3
- **Frontend**: Turbo, Stimulus, Tailwind CSS
- **Authentication**: Custom authentication with bcrypt
- **Background Jobs**: Solid Queue
- **Caching**: Solid Cache
- **Real-time**: Solid Cable (Action Cable)

## Installation

### Prerequisites

- Ruby 3.0+ 
- SQLite3

### Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd rails_llm_playground
   ```

2. **Install dependencies**
   ```bash
   bundle install
   npm install
   ```

3. **Environment Configuration**
   ```bash
   cp .env.example .env
   ```
   
   Configure your environment variables:
   ```env
   OPENAI_API_KEY=your_openai_api_key_here
   # Add other LLM provider API keys as needed
   ```

4. **Database Setup**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

5. **Start the Application**
   ```bash
   bin/dev
   ```
   
   The application will be available at `http://localhost:3000`

## Usage Guide

### Getting Started

1. **Register an Account** - Create a new user account or sign in
2. **Explore Models** - Visit `/models` to see available LLM providers and models (these are specific to RubyLLM but are helpful to see available options in other gems)
3. **Refresh Models** - Use the refresh button to seed the database with new models from RubyLLM registry

### Chat Interfaces

#### RubyLLM Chats (`/chats`)
- Select a model from the available providers
- Start conversations with your chosen LLM
- Messages are processed asynchronously
- Supports tool integration

#### RAIX Chats (`/raix_chats`)
- Create structured conversations using RAIX framework
- Choose from different conversation types
- Enhanced conversation management

#### RAIF Conversations (`/raif_conversations`)
- Access advanced conversation features through RAIF engine
- Sophisticated conversation flows
- Extended functionality through mounted engine

### Model Management

- **View Models** - Browse available models organized by provider
- **Model Details** - View specific model information and capabilities
- **Refresh** - Dynamically discover new models from providers

## Configuration

### Environment Variables

```env
# Required
OPENAI_API_KEY=your_openai_api_key

# Optional - add as needed for other providers
ANTHROPIC_API_KEY=your_anthropic_key
GOOGLE_API_KEY=your_google_key
```

### Adding New LLM Providers

The application is designed to be extensible. To add new providers:

1. Add the provider gem to your Gemfile
2. Configure the provider in your LLM integration
3. Update the Model refresh logic if needed

## Development

### Running Tests

```bash
rails test
rails test:system
```

### Code Quality

```bash
bundle exec rubocop
bundle exec brakeman
```

### Development Tools

- **Foreman** - Process management (`bin/dev`)
- **Web Console** - In-browser debugging
- **Debug** - Enhanced debugging capabilities

## Deployment

### Docker

A Dockerfile is included for containerized deployment (but has not been tested):

```bash
docker build -t rails-llm-playground .
docker run -p 3000:3000 rails-llm-playground
```

### Production Deployment

The application includes Kamal configuration for easy deployment (but has not been tested):

```bash
kamal deploy
```

## Contributing

At this time I am not looking for contributions. Feel free to fork or clone and expand this app however you like. If you have any ideas or suggestions, feel free to open an issue!

## Architecture Notes

### LLM Integration Patterns

This playground demonstrates three different approaches to LLM integration in Rails:

1. **Framework-Agnostic** - Fully custom implementation using Raix and defining persistence in callbacks
2. **Railsy-but-flexible** - Dead-simple setup using RubyLLM generated models and controllers
3. **Hardcore Rails** - Using mountable engine with Raif

### Background Processing

- Chat responses are processed asynchronously using Solid Queue
- Real-time updates delivered via Turbo Streams
- Graceful handling of long-running LLM requests with chunked responses

### Security Considerations

- API keys stored in environment variables
- User authentication required for all LLM interactions
- Input validation and sanitization
- Rate limiting considerations for production use

## License

This project is available as open source under the terms of the [MIT License](LICENSE).

## Support

For questions and support:
- Open an issue on GitHub
- Check the documentation for each integrated gem
- Review the example implementations in the codebase

## Notes

This project was created as a learning exercise and as a proof of concept for different LLM integration approaches. I found it challenging to answer these questions: "What are the best patterns for integrating an LLM into a Rails application? Are there any production-ready gems available?"
I have no intention of maintaining this project or making any changes to it (but maybe I will eventually). Use this as a reference or a jumping off point for your own exploration.
