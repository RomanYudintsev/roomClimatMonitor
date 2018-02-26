--[[ значения какие надо выводить
CO=0;
TEMP=0;
HUMI=0;
DEWPOINT=0;
AIR_PRESSURE=0;
]]--

function data_html() --conn)
    html_table = {"<meta http-equiv=\"refresh\" content=\"60\" />"}
    tmp_table = data_table()
    for index = 1, #tmp_table do
        table.insert(html_table, tmp_table[index].."<br/>")
    end
    return html_table
end

function data_string()
    return {table.concat(data_table(), " ")}
end

function data_table()
    update_data();
    return {
        "Uptime "..get_uptime()..". "
        ,"Уровень CO2 # "..CO2.." ppm."
        ,"Температура # "..TEMP.." °C."
        ,"Отн. влажность # "..HUMI.." %."
        ,"Точка росы # "..DEWPOINT.." °C."
        ,"Атмосферное давление # "..AIR_PRESSURE.." мм.рт.ст."
        -- ,"Атмосферное давление на уровне моря # "..AIR_PRESSURE_SEA.." мм.рт.ст."
    }
end

function data_metrics()
    update_data();
    return {
        "# HELP current level CO2.\r\n"
        ,"# TYPE v4core_climat_monitor_co2_current gauge\r\n"
        ,"v4core_climat_monitor_co2_current "..CO2.."\r\n"
        ,"# HELP just temperature.\r\n"
        ,"# TYPE v4core_climat_monitor_temperature gauge\r\n"
        ,"v4core_climat_monitor_temperature "..TEMP.."\r\n"
        ,"# HELP just humi.\r\n"
        ,"# TYPE v4core_climat_monitor_rel_humi gauge\r\n"
        ,"v4core_climat_monitor_rel_humi "..HUMI.."\r\n"
        ,"# HELP just dew point.\r\n"
        ,"# TYPE v4core_climat_monitor_dewpoint gauge\r\n"
        ,"v4core_climat_monitor_dewpoint "..DEWPOINT.."\r\n"
        ,"# HELP just air pressure.\r\n"
        ,"# TYPE v4core_climat_monitor_air_pressure gauge\r\n"
        ,"v4core_climat_monitor_air_pressure "..AIR_PRESSURE.."\r\n"
        -- ,"Атмосферное давление на уровне моря # "..AIR_PRESSURE_SEA.." мм.рт.ст."
    }
end

function get_uptime()
    ct = tmr.time();
    s = ct%60;
    m = math.floor(ct/60)%60;
    h = math.floor(ct/3600)%60
    ut = "# "..h.."h"..m.."m"..s.."s";
    return ut;
end

return {
    data_html = data_html,
    data_string = data_string,
    data_metrics = data_metrics
}
