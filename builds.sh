#!/bin/bash

cd /Users/apple/whitelabel/project

# Function to generate keystore for Android
function generateAndroidKeystore() {
    local storePassword=$1
    local keyPassword=$2

    keytool -genkey -v -keystore key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key \
            -storepass $storePassword -keypass $keyPassword \
            -dname "CN=Unknown, OU=Unknown, O=Unknown, L=Unknown, ST=Unknown, C=Unknown"
}

# Function to configure signing for Android
function configureAndroidSigning() {
    local storePassword=$1
    local keyPassword=$2
    local gradleFile="android/app/build.gradle"
    sed -i '' '/signingConfigs {/a\        release {\n            keyAlias "key"\n            keyPassword "'"$keyPassword"'"\n            storeFile file("key.jks")\n            storePassword "'"$storePassword"'"\n        }' $gradleFile
    sed -i '' 's/buildTypes {/buildTypes {\n        release {\n            signingConfig signingConfigs.release\n        }/' $gradleFile
}

# Function to configure signing for iOS
function configureIOSSigning() {
    # Not needed for iOS, handled in Xcode
    echo "No iOS signing configuration needed"
}

# Function to generate production build for Android
function generateAndroidBuild() {
    flutter build apk --release
}

# Function to generate production build for iOS
function generateiOSBuild() {
    flutter build ios --release
}

# Main function
function main() {
    local storePassword=$1
    local keyPassword=$2
    generateAndroidKeystore $storePassword $keyPassword
    configureAndroidSigning $storePassword $keyPassword
    configureIOSSigning
    generateAndroidBuild
    generateiOSBuild
}

# Run the main function with arguments for store password and key password
main "$@"