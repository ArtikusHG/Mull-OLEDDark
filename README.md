# Mull-OLEDDark
Since Firefox mobile (and thus, all of its forks) don't officially support an OLED dark theme, I decided to take matter into my own hands, and made a simple script that decompiles the apk, changes two lines in the resources to change the color scheme, and rebuilds the apk. This is an attempt to automate the entire process - this action will run every 24 hours, and if it finds a new build of Mull, it will download it, patch it, and publish a release.

# Why not build Mull from source?
Building the entire browser from source just to change two lines in the xml resources is uneconomical.

# How to use
This repo can be imported into Obtainium to directly download patched updates as soon as they're released. Feel free to use this on your own device, or modify it to patch other things. Security should not be a huge concern, since new builds are automated and run every 24 hours (unless you don't trust me, because I do have to sign this with my own keys - in this case just fork the repo and add your own action secrets).
