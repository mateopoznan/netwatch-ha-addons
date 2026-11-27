#!/command/with-contenv bashio
set -euo pipefail

BASE=https://device.mateopoznan.pl
ARCH=$(uname -m)
case "$ARCH" in
  x86_64|amd64) ARCH=amd64 ;;
  aarch64|arm64) ARCH=arm64 ;;
  *) bashio::log.error "Unsupported Home Assistant architecture: $ARCH"; exit 2 ;;
esac

BIN=/usr/local/bin/netwatch-agent
TMP_BIN="${BIN}.new"
curl -fsSL "$BASE/downloads/netwatch-linux-$ARCH" -o "$TMP_BIN"
chmod 755 "$TMP_BIN"
mv -f "$TMP_BIN" "$BIN"
CONFIG=/data/agent.json
if [ ! -s "$CONFIG" ]; then
  CODE=$(bashio::config 'enrollment_code')
  NAME=$(bashio::config 'device_name')
  [ -n "$NAME" ] || NAME="Home Assistant"
  if [ -z "$CODE" ]; then bashio::log.error "Set the one-use enrollment code in the app configuration."; exit 2; fi
  "$BIN" enroll -server "$BASE" -code "$CODE" -name "$NAME" -config "$CONFIG"
  chmod 600 "$CONFIG"
  bashio::log.info "Device registered. You can now remove the enrollment code from the app configuration."
fi
exec "$BIN" run -config "$CONFIG"
