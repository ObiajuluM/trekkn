ss24:
	adb connect 192.168.1.244

spxl:
	adb connect 192.168.1.176

2pxl:
	adb connect 192.168.53.25

s24_s24:
	adb connect 192.168.53.246

clean:
	flutter clean
	flutter pub get

# install production flavor
installp:
	flutter clean
	flutter pub get
	flutter build apk --flavor prod --target lib/main.dart
	flutter install --flavor prod

install:
	flutter clean
	flutter pub get
	flutter build apk --flavor dev --target lib/main_dev.dart
	flutter install --flavor dev 

# build production flavor
# shorebird release android --target lib/main.dart --flavor prod

# To create a patch for this release, run shorebird patch --platforms=android --flavor=prod --target=lib/main.dart --release-version=0.1.0+2