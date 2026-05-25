# Smart Power Plug Wattage Monitor (Rainmeter Skin)

Uses the [MqttClient Plugin](https://github.com/fvanroie/MqttClientPlugin) for Rainmeter.

## 📋 About

A lightweight Rainmeter skin that displays real-time wattage info from a smart power plug via MQTT.

![Example Screenshot](https://github.com/Dzhay/rainmeter-tasmota-skin/blob/main/tasmota-wattage/tasmota-wattage-example.png)

## ⚙️ Installation & Usage

1. Install the `.rmskin` package  
   *(Includes MqttClientPlugin v0.2.5)*

2. Open `tasmota-wattage.ini` and update the following:

   ```ini
   [mqttServer]
   Server=INPUT_MQTT_BROKER_IP_HERE  ; Replace with your MQTT broker IP

   [powerImport]
   Topic=POWERPLUG/TOPIC/SENSOR      ; Replace with your actual topic
   ```

3. Load the skin via Rainmeter.

## 🔌 Tasmota Changes

In your Tasmota console, run:

```
PowerDelta 101
```

This enables reporting when power usage changes by 1%.  
More info: [Tasmota PowerDelta Documentation](https://tasmota.github.io/docs/Commands/#powerdelta)

For other types of smart power plugs check documentation.

## 🪪 License

This project is licensed under the [GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.html).
