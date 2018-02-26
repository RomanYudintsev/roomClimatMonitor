wifi.sta.clearconfig()

function wifi_got_ip_cb(info)
    print("im ok")
    wifi_got_ip_handler(info)
end
wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, wifi_got_ip_cb)
--wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, wifi_got_ip_cb)

station_cfg={}
station_cfg.ssid="****"
station_cfg.pwd="****"
--station_cfg.ssid="***"
--station_cfg.pwd="****"
--station_cfg.login="***"
station_cfg.save=false
station_cfg.wpa2=false

wifi.setmode(wifi.STATION)
wifi.sta.config(station_cfg)

local senders = require "web_senders"
ip_sended = false

function startServer()
    dofile("web_server.lua")
end

function wifi_got_ip_handler(info)
    print("wifi_got_ip_handler called")
    if ip_sended then
        return 0
    end
    
    ip = wifi.sta.getip()
    if ip == nil then
        tmr.alarm(6, 5000, 0, wifi_got_ip_handler)
    else
        print("Hi, i'm up. My IP "..ip)
        ip_sended = true
        c_sec1, c_mksec1, c_rate1 = rtctime.get()
        print("get1", c_sec1, c_mksec1, c_rate1)
        sntp.sync(nil, function(sec, mksec, server, info)
                  print('sync', sec, mksec, server)
                  c_sec, c_mksec, c_rate = rtctime.get()
                  print("get", c_sec, c_mksec, c_rate)
                  --rtctime.set(sec, mksec, c_rate)
                  tmr.alarm(6, 100, 0, function ()
                    --sntp.sync()
                    senders.slack("Hi, i'm up. My IP "..ip)
                    tmr.alarm(6, 2000, 0, startServer)
                  end)
            end, function()
                print('failed!')
            end)
    end
end
wifi.sta.connect()

if not ip_sended then
    tmr.alarm(6, 15000, 0, wifi_got_ip_handler)
end
