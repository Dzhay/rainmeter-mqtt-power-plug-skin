; ---------------------------------------------------------------------------
;  Smart Power Plug Wattage Monitor - personal settings
;
;  Fill in your MQTT broker and the topic your plug publishes to, then
;  save. The skin reloads by itself within a few seconds.
;  Leave MqttUser and MqttPassword empty if your broker has no login.
;
;  This file is plain text - do not share it. Reinstalling the .rmskin
;  keeps the values you enter here.
; ---------------------------------------------------------------------------

[Variables]

; Broker IP or hostname, e.g. 192.168.1.100 or homeassistant.local
MqttServer=
; e.g. powerplug/tasmota_EXAMPLE/SENSOR
MqttTopic=

MqttUser=
MqttPassword=

; Size of the wattage text. Default: 23
FontSizeValue=23
