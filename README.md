# **Air monitor v 1.0** #

### binaries
/bin/esp_init_data_default.bin - bin from sdk version 2.2 (08)

    0x7C000 for 512 кБ (ESP-01, -03, -07 etc.)
    0xFC000 for 1 МБ (ESP8285, PSF-A85)
    0x1FC000 for 2 МБ (?)
    0x3FC000 for 4 МБ (ESP-12E, NodeMCU, WeMos D1 mini)
    
/bin/nodemcu_float.bin - compiled firmware with patch sdk2.2 && wpa2 enterprise 

# lua scripts

bmp280 - for bmp280 sensor temperature & humi & air pressure

init - for start all monitoring

ligther - blink diod, just signal when all works

mhz19b_pwm - for mh-z19b sensor CO2

web - for start all net communications

web_answers - methods for generate answers on http request

web_senders - methods for send info to slack, or other

web_server - scripts for start http-server after connected and send data to slack

wifi_eventmon - script for include and monitorins wifi events

# License

[MIT](https://github.com/RomanYudintsev/roomClimatMonitor/blob/master/LICENSE) Enjoy :)
