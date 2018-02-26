-- use pin 1 as the input pulse width counter
local pin = 5;
local h, th, l, tl = 0, 0, 0, 0;
local ct, ctr, ppm = 0, 0, 0;
local c = 0;
local CO2_PPM = 0;
local function pin1cb(level, pulse)
	ctr = tmr.now()/1000;
	if level == 0 then
		h = ctr;
		th = h - l;
	else
		l = ctr;
		tl = l - h;
	end
    c = c * 2 + 1;
    if c > 12 then
        ppm = 5000 * (th - 2) / (th + tl - 4);
        gpio.trig(pin, "none");
        gpio.mode(pin, gpio.INPUT);

        CO2_PPM = ppm;
        --print("ppm ::: "..ppm);
        --print("th ::: "..th);
        --print("pulse ::: "..(math.floor(pulse/1000+0.5)), "th + tl ::: "..(math.floor(th+tl+0.5)));
        c = 0;
        MHZ19B_ENABLED = true
    end
end

function start_mhz19b()
    gpio.mode(pin, gpio.INT);
    gpio.trig(pin, "both", pin1cb);
end

tmr.alarm(3, 30000, 1, start_mhz19b);

function get_mhz19b_data()
    return math.floor(CO2_PPM);
end
