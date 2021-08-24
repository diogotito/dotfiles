require 'cairo'
local json = require ("dkjson")
local http_util = require("http.util")

-- Variables we are interested in
local router_variables = setmetatable({
    network_provider = '',
    signalbar = 0,
    battery_charging = 0,
    battery_vol_percent = 0,
    realtime_tx_bytes = 0,
    realtime_rx_bytes = 0,
    realtime_tx_thrpt = 0,
    realtime_rx_thrpt = 0,
    monthly_rx_bytes = 0,
    monthly_tx_bytes = 0,
}, {
    __index = {
        get_keys = function(self)
            local keys = {}
            for k in next, self do
                keys[#keys + 1] = k
            end
            return keys
        end
    }
})


-- Build a special cURL command that can communicate with the damn router
--   * A plain cURL command (as given by Conky's "${curl ...}") won't do :(
--   * I'd need to go too low level with lua-http because the router doesn't
--       send CRLF consistently after every line in the HTTP response and
--       lua-http bails out (its source code matches each line against \r\n$).
-- Maybe I should have just written a shell script that uses cURL and jq and
-- prints text with conky objects/variables for ${texecpi}
-- But hey, my signal bars look pretty and for now I can draw even fancier
-- stuff whenever I want, plus I learned Cairo and a few new Lua concepts!

local curl_fmt <const> = 'curl --referer "%s" --silent --insecure "%s?%s"'
local referer  <const> = 'http://192.168.0.1/index.html'
local base_uri <const> = 'http://192.168.0.1/goform/goform_get_cmd_process'
local query    <const> = http_util.dict_to_query({
    multi_data = '1',
    cmd = table.concat(router_variables:get_keys(), ",")
})

local curl_cmd <const> = curl_fmt:format(referer, base_uri, query)


-- Turn every "variable" into a Lua function that can be called from the Conky
-- configuration like this: ${lua variable}

for k in next, router_variables do
    _ENV['conky_' .. k] = function()
        return router_variables[k]
    end
end


--
-- Helper Lua functions
--

-- "realtime", i.e., after turning it off and on
function conky_realtime_total()
    local rx = router_variables.realtime_rx_bytes
    local tx = router_variables.realtime_tx_bytes
    return rx + tx
end

function conky_realtime_MBs()
    return ("%.3f MiB"):format(conky_realtime_total() / 2^20)
end

function conky_realtime_GBs()
    return ("%.3f GiB"):format(conky_realtime_total() / 2^30)
end

function conky_realtime_GBs_percent(realtime_limit)
    return conky_realtime_total() / (realtime_limit * 2^30) * 100
end

-- monthly
function conky_monthly_total()
    local rx = router_variables.monthly_rx_bytes
    local tx = router_variables.monthly_tx_bytes
    return rx + tx
end

function conky_monthly_total_GBs()
    return ("%.3f GiB"):format(conky_monthly_total() / 2^30)
end

function conky_monthly_total_GBs_percent(monthly_limit)
    return conky_monthly_total() / (monthly_limit * 2^30) * 100
end


-- monthly
function conky_thrpt()
    local rx = router_variables.realtime_rx_thrpt
    local tx = router_variables.realtime_tx_thrpt
    return rx + tx
end

function conky_thrpt_KB()
    return ("%.3f KiB"):format(conky_thrpt() / 2^10)
end



-- Pretty JSON

function conky_pretty_print()
    return json.encode(router_variables, {indent = true})
end

-- Conky hooks

function conky_startup()
    update_router()
end

function conky_main_draw()
    if not conky_window then return end

    local cs = cairo_xlib_surface_create(
        conky_window.display,
        conky_window.drawable,
        conky_window.visual,
        conky_window.width,
        conky_window.height
    )

    local cr = cairo_create(cs)

    -- io.write("."); io.flush()
    if tonumber(conky_parse("${updates}")) % 4 == 0 then
        update_router()
        write_to_file_for_i3_status()
    end

    draw(cr)

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
end

function draw(cr)
    local num_bars   <const> = 5
    local bar_width  <const> = 5
    local bar_gap    <const> = 2
    local bar_height <const> = 14
    local bar_stroke <const> = {0.0, 0.0, 1.0}
    local bar_fill   <const> = {0.39, 0.87, 0.47}
    local width      <const> = conky_window.width
    local padding    <const> = conky_window.border_inner_margin - 1

    cairo_set_antialias(cr, CAIRO_ANTIALIAS_NONE)
    cairo_set_line_width (cr, 1);

    for i = 1, num_bars do
        local x = width - padding - (num_bars + 1 - i) * (bar_width + bar_gap)
        local height = -(i / num_bars) * bar_height
        local y = 25
        cairo_set_source_rgb(cr, table.unpack(bar_stroke))
        cairo_rectangle(cr, x, y, bar_width, height)
        cairo_stroke(cr)
        if router_variables.signalbar >= i then
            cairo_set_source_rgb(cr, table.unpack(bar_fill))
            cairo_rectangle(cr, x - 1, y - 1, bar_width + 0, height + 0)
            cairo_fill(cr)
        end
    end
end

function update_router()
    local curl_process = assert(io.popen(curl_cmd))
    jsontext = assert(curl_process:read("*a"))
    local jsonobj = assert(json.decode(jsontext))
    assert(curl_process:close())

    for k, v in next, jsonobj do
        router_variables[k] = tonumber(v) or v
    end
end

function write_to_file_for_i3_status()
    local the_file = assert(io.open("/tmp/dados.txt", "w"))
    the_file:write(conky_monthly_total_GBs(), ' | ', conky_realtime_MBs())
    the_file:close()
end
