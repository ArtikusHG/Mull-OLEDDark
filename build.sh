#!/bin/bash
data=$(curl -s https://divestos.org/fdroid/official/index-v1.json)
hash=$(echo $data | jq -r '.packages."us.spotco.fennec_dos"[0].hash')
if echo "$hash latest.apk" | sha256sum -c -; then
	echo "Latest apk already patched"
	exit 1
fi
rm latest.apk
apk=$(echo $data | jq -r '.packages."us.spotco.fennec_dos"[0].apkName')
echo "https://divestos.org/fdroid/official/$apk"
wget $(echo "https://divestos.org/fdroid/official/$apk") -O latest.apk

ls
pwd

echo "Decompiling and patching apk file..."
rm -rf patched patched_signed.apk
apktool d -s latest.apk -o patched 
rm -rf patched/META-INF

sed -i 's/<color name="fx_mobile_layer_color_1">.*/<color name="fx_mobile_layer_color_1">@color\/photonBlack<\/color>/g' patched/res/values-night/colors.xml
sed -i 's/<color name="fx_mobile_layer_color_2">.*/<color name="fx_mobile_layer_color_2">@color\/photonDarkGrey90<\/color>/g' patched/res/values-night/colors.xml

apktool b patched -o patched.apk --use-aapt2 -a /usr/bin/aapt2

echo "Aligning apk file..."
zipalign 4 patched.apk patched_signed.apk
rm -rf patched patched.apk
