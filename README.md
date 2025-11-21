# AI Hackathon - Find Similar Cars

This is a demo project representing the UI for AI workflow in finding similar cars.

## Prerequisites

Before you begin, ensure you have Flutter installed on your system:

- **Flutter SDK**: Version 3.0.0 or higher
- **Dart SDK**: Included with Flutter
- For installation instructions, visit: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/syht1602/ai-hackathon-find-similar.git
cd ai-hackathon-find-similar
```

### 2. Initialize the Project

#### On Linux/macOS:
```bash
./init.sh
```

#### On Windows:
```cmd
init.bat
```

#### Manual Setup:
If you prefer to set up manually:

```bash
# Get Flutter dependencies
flutter pub get

# Verify your Flutter installation
flutter doctor
```

### 3. Run the Application

#### For Web:
```bash
flutter run -d chrome
```

#### For Mobile (Android/iOS):
```bash
# List available devices
flutter devices

# Run on a specific device
flutter run -d <device-id>

# Or simply run on the default device
flutter run
```

## Updating Dependencies

To update the project dependencies later:

```bash
# Get the latest compatible versions
flutter pub get

# Upgrade to the latest versions (updates pubspec.lock)
flutter pub upgrade
```

## Project Structure

```
ai-hackathon-find-similar/
├── lib/                  # Application source code
│   └── main.dart        # Main entry point
├── test/                # Test files
│   └── widget_test.dart # Widget tests
├── web/                 # Web-specific files
│   ├── index.html      # HTML entry point
│   └── manifest.json   # Web app manifest
├── android/            # Android-specific files (to be generated)
├── ios/                # iOS-specific files (to be generated)
├── pubspec.yaml        # Project dependencies
├── analysis_options.yaml # Linter configuration
├── init.sh             # Setup script for Linux/macOS
├── init.bat            # Setup script for Windows
└── README.md           # This file
```

## Development

### Running Tests
```bash
flutter test
```

### Analyzing Code
```bash
flutter analyze
```

### Building for Production

#### Web:
```bash
flutter build web
```

#### Android:
```bash
flutter build apk
```

#### iOS:
```bash
flutter build ios
```

## Troubleshooting

If you encounter issues:

1. Make sure Flutter is properly installed: `flutter doctor`
2. Clean the project: `flutter clean`
3. Re-fetch dependencies: `flutter pub get`
4. Update Flutter to the latest version: `flutter upgrade`

## License

This project is a demo/hackathon project.
