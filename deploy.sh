#flutter clean
#flutter pub get
flutter build web --web-renderer html --release
cd build/web
python3 -m http.server 8000
