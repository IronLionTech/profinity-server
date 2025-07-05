#!/bin/bash

set -e

APP_DIR="/opt/ProfinityApp"
NGROK_CONFIG_DIR="$HOME/.config/ngrok"
NGROK_CONFIG_FILE="$NGROK_CONFIG_DIR/ngrok.yml"

echo "🔧 Installing prerequisites..."
sudo apt update
sudo apt install -y unzip curl

# Download ngrok if not present
if ! command -v ngrok &> /dev/null; then
  echo "⬇️ Downloading ngrok..."
  curl -s https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -o ngrok.zip
  unzip ngrok.zip
  sudo mv ngrok /usr/local/bin/
  rm ngrok.zip
fi

echo "📁 Setting up Profinity files..."
sudo mkdir -p "$APP_DIR"
sudo cp -r Web/* "$APP_DIR"

echo "🧰 Configuring ngrok..."
mkdir -p "$NGROK_CONFIG_DIR"

tee "$NGROK_CONFIG_FILE" > /dev/null <<EOF
version: 2
authtoken: 2h1Ywky1qBcjBd7jWbId383DhBi_7KXnEhmdF6ypFCcMQKeMR
tunnels:
  profinity:
    addr: 18080
    proto: http
    hostname: ironlionstelemetry.org
EOF

echo "🚀 Creating launch script..."
tee "$APP_DIR/start.sh" > /dev/null <<EOF
#!/bin/bash
cd "$APP_DIR"
# Run ngrok in background
nohup ngrok start profinity > /dev/null 2>&1 &
echo "🌐 Serving Profinity at https://ironlionstelemetry.org"
EOF

chmod +x "$APP_DIR/start.sh"

echo "✅ Installation complete!"
echo "➡️ Run: sudo $APP_DIR/start.sh"
