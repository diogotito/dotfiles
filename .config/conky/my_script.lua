#!/usr/bin/env lua

require 'cairo'
local json = require ("dkjson")

local router_variables = setmetatable({
    network_provider = '',
    signalbar = '',
    battery_charging = '',
    battery_vol_percent = '',
    realtime_tx_bytes = '',
    realtime_rx_bytes = '',
    realtime_tx_thrpt = '',
    realtime_rx_thrpt = '',
    monthly_rx_bytes = '',
    monthly_tx_bytes = '',
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

for k in next, router_variables do
    _ENV['conky_' .. k] = function()
        return router_variables[k]
    end
end

local jsontext = ''

function conky_pretty_print()
    return json.encode(router_variables, {indent = true})
end

function conky_get_received_json_text()
    return jsontext
end

function conky_startup(...)
    print("Starting up")
    print(...)
    print("--------------")
    print(' display:', conky_window.display)
    print('drawable:', conky_window.drawable)
    print('  visual:', conky_window.visual)
    print("--------------")
    print(_G)
end

function conky_main_draw(...)
    if not conky_window then return end

    local cs = cairo_xlib_surface_create(
        conky_window.display,
        conky_window.drawable,
        conky_window.visual,
        conky_window.width,
        conky_window.height
    )

    local cr = cairo_create(cs)

    if tonumber(conky_parse("${updates}")) % 4 == 0 then
        update_router()
    end

    cairo_set_source_rgba(cr, 0.1, 0.2, 0.3, 1)
    cairo_move_to(cr, 0, 0)
    cairo_line_to(cr, 300, 100)
    cairo_stroke(cr)

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
end

function update_router()
    local curl = io.popen("curl -s 'http://192.168.0.1/goform/goform_get_cmd_process?cmd=" .. table.concat(router_variables:get_keys(), ",") .. "&multi_data=1' -e http://192.168.0.1/index.html")
    -- local curl = io.popen("date")
    jsontext = curl:read("*a")
    local jsonobj, _, err = json.decode(jsontext)
    if err then
        print("JSON ERROR:", err)
        return
    end
    for k, v in next, jsonobj do
        router_variables[k] = tonumber(v) or v
    end
end

