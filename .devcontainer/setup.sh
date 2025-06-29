#!/bin/bash

echo "🚀 Setting up Go development environment..."

# Send codespace started event to Wilco servers
if [ -f "/workspaces/.wilco" ]; then
    WILCO_ID="`cat /workspaces/.wilco`"
    
    if [ -n "$CODESPACE_NAME" ] && [ -n "$ENGINE_BASE_URL" ]; then
        CODESPACE_BACKEND_HOST=$(curl -s "${ENGINE_BASE_URL}/api/v1/codespace/backendHost?codespaceName=${CODESPACE_NAME}&portForwarding=${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}" | jq -r '.codespaceBackendHost')
        
        if [ -n "$CODESPACE_BACKEND_HOST" ] && [ "$CODESPACE_BACKEND_HOST" != "null" ]; then
            CODESPACE_BACKEND_URL="https://${CODESPACE_BACKEND_HOST}"
            export ENGINE_EVENT_ENDPOINT="${ENGINE_BASE_URL}/users/${WILCO_ID}/event"
            
            # Update engine that codespace started for user
            curl -L -X POST "${ENGINE_EVENT_ENDPOINT}" -H "Content-Type: application/json" --data-raw "{ \"event\": \"github_codespace_started\" }" > /dev/null 2>&1
        fi
    fi
fi

# Initialize Go module if it doesn't exist
if [ ! -f "go.mod" ]; then
    echo "📦 Initializing Go module..."
    go mod init go-quiz-api
fi

# Ensure Go bin is in PATH
echo "🔧 Configuring Go PATH..."
if ! grep -q 'export PATH="$PATH:$HOME/go/bin"' ~/.bashrc; then
    echo 'export PATH="$PATH:$HOME/go/bin"' >> ~/.bashrc
fi
export PATH="$PATH:$HOME/go/bin"

# Install Air for hot reloading
echo "🔄 Installing Air for hot reloading..."
go install github.com/air-verse/air@latest

# Download dependencies and create go.sum
echo "📦 Downloading Go dependencies..."
go mod tidy

# Configure Codespace ports (if in Codespaces)
if [ "$CODESPACE_NAME" ]; then
    gh codespace ports visibility 8080:public --codespace $CODESPACE_NAME 2>/dev/null || true
fi

# Add helpful aliases for Go development
echo "alias go-run='air'" >> ~/.bashrc
echo "alias go-build='go build .'" >> ~/.bashrc
echo "alias go-test='go test ./...'" >> ~/.bashrc
echo "alias go-mod='go mod'" >> ~/.bashrc

# Welcome message
echo "printf \"\n🐹 Go Development Ready! Use GitHub Copilot for assistance!\n\"" >> ~/.bashrc
echo "printf \"💡 Use 'go-run' to start with hot reload\n\"" >> ~/.bashrc

echo "✅ Setup complete!"