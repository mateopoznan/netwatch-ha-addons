# Netwatch Agent

The app sends the Home Assistant host's network interfaces, public IP, uptime, and CPU load to your private Netwatch dashboard every five minutes.

## Setup

1. In the Netwatch panel, choose **Dodaj urządzenie** and copy a fresh Unix/Linux installation code.
2. Install this app from the Netwatch repository.
3. Open the app configuration. Paste the one-use code into `enrollment_code`; optionally change `device_name`.
4. Save and start the app. Wait for the device to appear in Netwatch.
5. Clear `enrollment_code` from the app configuration. The persistent device token remains in `/data/agent.json`.

The app uses host networking so that it can read the host's IP addresses. It does not need inbound ports. It supports Home Assistant OS on amd64 and aarch64.

If the app is removed, its stored token is removed with its persistent app data. Generate a new enrollment code when installing it again.
