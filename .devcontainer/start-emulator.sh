#!/bin/bash

# Start the emulator in the background
echo "Starting Android emulator..."
export DISPLAY=:1
Xvfb :1 -screen 0 1280x800x24 &
nohup emulator -avd test_emulator -no-audio -no-boot-anim -gpu swiftshader_indirect -no-snapshot -no-window &

# Wait for the emulator to boot completely
echo "Waiting for emulator to start..."
adb wait-for-device
adb shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done'
echo "Emulator started and ready!"

# Keep this script running to maintain the Xvfb session
# You can kill this process when done with the emulator
wait