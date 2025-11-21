#!/bin/bash

# AI Hackathon Find Similar Cars - Initialization Script
# This script sets up the Flutter project after cloning

set -e

echo "========================================"
echo "AI Hackathon Find Similar Cars - Setup"
echo "========================================"
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed!"
    echo ""
    echo "Please install Flutter first:"
    echo "  Visit: https://flutter.dev/docs/get-started/install"
    echo ""
    exit 1
fi

echo "✓ Flutter is installed"
echo ""

# Display Flutter version
echo "Flutter version:"
flutter --version
echo ""

# Get Flutter dependencies
echo "📦 Getting Flutter dependencies..."
flutter pub get
echo ""

# Verify installation
echo "🔍 Verifying installation..."
flutter doctor
echo ""

echo "========================================"
echo "✅ Setup Complete!"
echo "========================================"
echo ""
echo "To run the app:"
echo "  - For web: flutter run -d chrome"
echo "  - For mobile: flutter run"
echo "  - For all devices: flutter devices"
echo ""
echo "To update dependencies later:"
echo "  flutter pub get"
echo ""
echo "To upgrade dependencies:"
echo "  flutter pub upgrade"
echo ""
