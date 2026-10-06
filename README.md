# Smart Power Plug Wattage Monitor (Rainmeter Skin)

Uses the [MqttClient Plugin](https://github.com/fvanroie/MqttClientPlugin) for Rainmeter.

## 📋 About

A lightweight Rainmeter skin that displays real-time wattage info from a smart power plug via MQTT.

![Example Screenshot](docs/screenshot.png)

<img src="docs/demo.gif" alt="Live wattage updates" width="243">

## ⚙️ Installation & Usage

1. Download `Installer/rainmeter-mqtt-power-1.0.rmskin` and install it.
   *(Includes MqttClientPlugin v0.2.5)*

2. Right-click the skin, choose **Edit settings** and fill in:

   ```ini
   MqttServer=192.168.1.100                     ; your MQTT broker IP or hostname
   MqttTopic=powerplug/tasmota_EXAMPLE/SENSOR   ; your actual topic
   MqttUser=                                    ; only if your broker needs a login
   MqttPassword=
   ```

3. Save. The skin reloads by itself within a few seconds.

To change the size of the wattage text, set `FontSizeValue` in the same file
(default `23`). The card resizes to fit.

Upgrading with a newer `.rmskin` keeps your settings. `Settings.inc` is stored
as plain text, so never share it.

Colours, font face and layout are in `@Resources/Variables.inc`.

## 🔌 Tasmota Changes

Tips if you're using a Tasmota smart power plug

In your Tasmota console, run:

```
PowerDelta 101
```

This enables reporting when power usage changes by 1%.  
More info: [Tasmota PowerDelta Documentation](https://tasmota.github.io/docs/Commands/#powerdelta)

For other types of smart power plugs check documentation.

## 🛠️ Building

```powershell
powershell -ExecutionPolicy Bypass -File .\build.ps1
```

This writes `Installer\rainmeter-mqtt-power-<version>.rmskin`, taking the version and
author from `rainmeter-mqtt-power.ini` and bundling the plugin DLLs from `Plugins\`.

## 🪪 License

This project is licensed under the [GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.html).
