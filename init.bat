@echo off
REM AI Hackathon Find Similar Cars - Initialization Script for Windows
REM This script sets up the Flutter project after cloning

echo ========================================
echo AI Hackathon Find Similar Cars - Setup
echo ========================================
echo.

REM Check if Flutter is installed
where flutter >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo X Flutter is not installed!
    echo.
    echo Please install Flutter first:
    echo   Visit: https://flutter.dev/docs/get-started/install
    echo.
    exit /b 1
)

echo √ Flutter is installed
echo.

REM Display Flutter version
echo Flutter version:
call flutter --version
echo.

REM Get Flutter dependencies
echo Getting Flutter dependencies...
call flutter pub get
echo.

REM Verify installation
echo Verifying installation...
call flutter doctor
echo.

echo ========================================
echo Setup Complete!
echo ========================================
echo.
echo To run the app:
echo   - For web: flutter run -d chrome
echo   - For mobile: flutter run
echo   - For all devices: flutter devices
echo.
echo To update dependencies later:
echo   flutter pub get
echo.
echo To upgrade dependencies:
echo   flutter pub upgrade
echo.
pause
