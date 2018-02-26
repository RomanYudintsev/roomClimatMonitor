local url_to_slack_channel = "https://hooks.slack.com/services/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"
--local url_to_slack_channel = "https://httpbin.org/post"

function slack(msg)
    http.post(url_to_slack_channel,
        'Content-Type: text/xml\r\n',
        '{"text": "Its works. Message from agent '..msg..'" }',
        slack_cb)
end

local function slack_cb(code, data)
    if (code < 0) then
        print("HTTP request failed")
    else
        print(code, data)
    end
end

return {
    slack = slack,
}
