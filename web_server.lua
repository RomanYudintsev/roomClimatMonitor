local answers = require "web_answers"

function http_handler(sck_conn)
    print("createServer")
    sck_conn:on("receive", receive_handler)
    sck_conn:on("sent", function()sck_conn:close()end)
end
function createServer()
    print("Start a simple http server")
     -- Start a simple http server
    srv=net.createServer(net.TCP)
    srv:listen(80, http_handler)
end

function sent_handler(conn)
    conn:close()
end

function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch(delimiter) do
        table.insert(result, match);
    end
    return result;
end

function receive_handler(conn, payload)
--payload from requests :: GET /test/payload HTTP/1.1
    print("payload from requests :: "..payload)
    --detect = string.split(payload, " ")[1]
    detect = split(payload, "[^%s]+")[2]
    print("payload from requests :: "..detect)
    local data_to_send = {}
    if detect == "/string" then
        data_to_send = answers.data_string()
    elseif detect == "/metrics" then
        data_to_send = answers.data_metrics()
    else
        data_to_send = answers.data_html()
    end

    for data_line = 1, #data_to_send do
        conn:send(data_to_send[data_line])
    end
end

createServer()
print("web server loaded - do it")
