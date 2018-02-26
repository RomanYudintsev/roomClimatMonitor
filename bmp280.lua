local sda, scl = 2, 1;

i2c.setup(0, sda, scl, i2c.SLOW);
bme280.setup();

local TEMP, HUMI, DEWPOINT, AIR_PRESSURE, AIR_PRESSURE_SEA = 0, 0, 0, 0, 0;
BMP280_ENABLED = true;

function get_bmp280_data()
    P, T = bme280.baro();
    H, T = bme280.humi();
    D = bme280.dewpoint(H, T);

    P_MM_HG = 0.7500637554192 * P/1000; -- convert gPa to mm.hg.st

    TEMP = string.format("%5.2f", T/100);
    HUMI = string.format("%5.2f", H/1000);
    DEWPOINT = string.format("%5.2f", D/100);
    AIR_PRESSURE = string.format("%6.2f", P_MM_HG);

    -- for calculate on sea level
    --local alt=120; -- altitude of the measurement place
    --PS = bme280.qfe2qnh(P, alt)
    --P_SEA_MM_HG = 0.7500637554192 * PS/1000;
    --AIR_PRESSURE_SEA = string.format("%i.%03d", P_SEA_MM_HG, P_SEA_MM_HG%100);

    return TEMP, HUMI, DEWPOINT, AIR_PRESSURE --, AIR_PRESSURE_SEA
end
