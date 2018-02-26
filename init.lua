--wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, wifi_got_ip_handler)
wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, function(T)
 print("\n\tSTA - CONNECTED".."\n\tSSID: "..T.SSID.."\n\tBSSID: "..
 T.BSSID.."\n\tChannel: "..T.channel)
 end)

 wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, function(T)
 print("\n\tSTA - GOT IP".."\n\tStation IP: "..T.IP.."\n\tSubnet mask: "..
 T.netmask.."\n\tGateway IP: "..T.gateway)
 end)

function startup()
    print("startup")
    dofile("ligther.lua")
    dofile("web.lua")

    tmr.alarm(0, 30000, 0, startcollectdata)
end

function startcollectdata()
    dofile("bmp280.lua")
    dofile("mhz19b_pwm.lua")
end

MHZ19B_ENABLED, CO2 = false, 0; -- from mhz19b_pwm ( MH-Z19b )
BMP280_ENABLED, TEMP, HUMI, DEWPOINT, AIR_PRESSURE = false, 0, 0, 0, 0; -- from bmp280 ( BME/BMP280 )
function update_data()
    if MHZ19B_ENABLED then
        CO2 = get_mhz19b_data();
    end
    if BMP280_ENABLED then
        TEMP, HUMI, DEWPOINT, AIR_PRESSURE = get_bmp280_data();
    end
end

tmr.alarm(0, 5000, 0, startup)
