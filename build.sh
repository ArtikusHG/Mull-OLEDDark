#!/bin/bash
data=$(curl -s https://divestos.org/fdroid/official/index-v1.json)
apk=$(echo $data | jq -r '.packages."us.spotco.fennec_dos"[0].apkName')
wget $(echo "https://divestos.org/fdroid/official/$apk") -O latest.apk

echo "Decompiling and patching apk file..."
rm -rf patched patched_signed.apk
apktool d -s latest.apk -o patched 
rm -rf patched/META-INF

sed -i 's/<color name="fx_mobile_layer_color_1">.*/<color name="fx_mobile_layer_color_1">@color\/photonBlack<\/color>/g' patched/res/values-night/colors.xml
sed -i 's/<color name="fx_mobile_layer_color_2">.*/<color name="fx_mobile_layer_color_2">@color\/photonDarkGrey90<\/color>/g' patched/res/values-night/colors.xml

aapt2 --help

apktool b patched -o patched.apk -a /usr/bin/aapt2

echo "Aligning apk file..."
zipalign 4 patched.apk patched_signed.apk
rm -rf patched patched.apk
