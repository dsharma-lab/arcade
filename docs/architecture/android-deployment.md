# Android Deployment Guide

---

## 1. Prerequisites

### Install Flutter

```bash
# Option A: via brew (macOS)
brew install --cask flutter

# Option B: manual (download SDK from flutter.dev)
# Add to ~/.zshrc:
export PATH="$HOME/development/flutter/bin:$PATH"

# Verify
flutter doctor
```

Flutter doctor will flag any missing dependencies. Fix all items marked `[✗]` before proceeding.

### Required Tools

- Flutter SDK ≥ 3.19.0
- Android Studio (for Android SDK and emulator)
- Java 17+ (`java -version`)
- ADB (Android Debug Bridge — bundled with Android Studio)

---

## 2. Configure Android

### Enable USB Debugging on your device

1. Go to **Settings → About Phone**
2. Tap **Build Number** 7 times to enable Developer Options
3. Go to **Settings → Developer Options**
4. Enable **USB Debugging**
5. Connect your device via USB and accept the trust prompt

### Verify device is recognised

```bash
flutter devices
# Should list your Android device
adb devices
# Should show your device serial number
```

---

## 3. Run on Device (Development)

```bash
cd /Users/shrutirastogi/Documents/GitProjects/lab/arcade

# Get dependencies first
flutter pub get

# Run on connected Android device (hot reload enabled)
flutter run

# Run on a specific device
flutter run -d <device-id>

# Run in release mode (no hot reload, closer to production)
flutter run --release
```

---

## 4. Build Debug APK

```bash
flutter build apk --debug

# Output:
# build/app/outputs/flutter-apk/app-debug.apk

# Install directly to connected device
adb install build/app/outputs/flutter-apk/app-debug.apk

# Or use flutter install
flutter install
```

---

## 5. Build Release APK (for distribution)

### Step 1: Create a keystore (first time only)

```bash
keytool -genkey -v \
  -keystore ~/gamevault-keystore.jks \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias gamevault

# Keep the keystore file PRIVATE — never commit it to git!
```

### Step 2: Configure signing in Flutter

Create `android/key.properties` (gitignored):

```properties
storePassword=<your-keystore-password>
keyPassword=<your-key-password>
keyAlias=gamevault
storeFile=<path-to>/gamevault-keystore.jks
```

Update `android/app/build.gradle` to load `key.properties` (standard Flutter signing config).

### Step 3: Build release APK

```bash
flutter build apk --release

# Output:
# build/app/outputs/flutter-apk/app-release.apk
```

### Step 4: Build App Bundle (for Play Store)

```bash
flutter build appbundle --release

# Output:
# build/app/outputs/bundle/release/app-release.aab
# This is the file to upload to Play Store
```

---

## 6. Play Store Upload

1. Go to [Google Play Console](https://play.google.com/console)
2. Create a new app
3. Fill in: title, description, category (Games > Casual), content rating
4. Upload `app-release.aab` in **Production → Create new release**
5. Add screenshots (minimum 2 phone screenshots)
6. Submit for review

> Note: First release review can take 3–7 days.

---

## 7. Emulator (No Physical Device)

```bash
# List available emulators
flutter emulators

# Launch an emulator
flutter emulators --launch <emulator-id>

# Then run the app
flutter run
```

---

## 8. Common flutter doctor Issues

| Issue | Fix |
|-------|-----|
| Android SDK not found | Open Android Studio → SDK Manager → install SDK |
| Java not found | `brew install openjdk@17` |
| ADB connection refused | Unplug and replug USB, re-enable USB debugging |
| License not accepted | `flutter doctor --android-licenses` |
| Xcode not found (iOS) | Install Xcode from App Store (R3 only) |
