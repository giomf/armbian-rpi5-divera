#!/bin/bash

# Browser-Skript für Kiosk-Modus
chromium-browser \
  --kiosk \
  --disable-features=TranslateUI \
  --disable-infobars \
  --noerrdialogs \
  --disable-session-crashed-bubble \
  --disable-pinch \
  --overscroll-history-navigation=0 \
  --incognito \
  --disable-restore-session-state \
  --start-maximized \
  --start-fullscreen \
  --disable-translate \
  --no-first-run \
  --disable-features=DialMediaRouteProvider \
  --autoplay-policy=no-user-gesture-required \
  https://www.google.com/
