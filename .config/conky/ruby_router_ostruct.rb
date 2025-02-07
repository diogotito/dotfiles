#!/usr/bin/env ruby
require "json"
require "open-uri"

URI::HTTP.build(
  host: "192.168.0.1",
  path: "/goform/goform_get_cmd_process",
  query: URI.encode_www_form(
    multi_data: 1,
    cmd: %w(
      network_provider
      signalbar
      battery_charging
      battery_vol_percent
      realtime_tx_bytes
      realtime_rx_bytes
      realtime_tx_thrpt
      realtime_rx_thrpt
      monthly_rx_bytes
      monthly_tx_bytes
      station_list
    ).join(","),
  ),
)
  .read("Referer" => "http://192.168.0.1/index.html")
  .then { |res| JSON.parse(res) }
  .transform_values! { |value| Integer(value, exception: false) or value }
  .then { |stats| OpenStruct.new(stats) }
  .instance_eval do

    def fancy_signal
      bars = "\u2581\u2582\u2584\u2586\u2588"
      bars[...signalbar] + $black + bars[signalbar..] + $reset
    end

    def fancy_battery =
      case battery_vol_percent
      when 0...50
        ?🪫
      when 50..100
        ?🔋
      end

    def realtime_GiB =
      "%.3f GiB" % (realtime_rx_bytes + realtime_tx_bytes).fdiv(2 ** 30)

    def monthly_total =
      monthly_rx_bytes + monthly_tx_bytes

    def monthly_GiB =
      "%.3f GiB" % monthly_total.fdiv(2 ** 30)

    $reset = "\033[0m"
    $bold  = "\033[1m"
    $black = "\033[30m"
    $cyan  = "\033[96m"

    printf "╭───────────────────────────────────────────╮\n"
    printf "│ %-21s %36s │\n", "#{fancy_battery} #{battery_vol_percent} %",
                               "#$cyan#{network_provider}#$reset #{fancy_signal}"
    printf "├╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┤\n"
    printf "│ %-28s %20s │\n", "#$bold#{monthly_GiB}#$reset / 30 GiB",
                               "↗ #{realtime_tx_thrpt} B"
    printf "│ %-20s %20s │\n", realtime_GiB,
                               "↘ #{realtime_rx_thrpt} B"
    printf "├╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┤\n"
  end

URI("http://192.168.0.1/goform/goform_get_cmd_process?cmd=station_list")
  .read("Referer" => "http://192.168.0.1/index.html")
  .then { |res| JSON.parse(res) }
  .then { |res| res["station_list"] }
  .then { |res| res == "" ? [{'hostname' => 'Need to login', 'ip_addr' => '...'}]
                          : res }
  .map { |device| device.fetch_values("hostname", "ip_addr") }
  .each { |host, ip| printf "│ %-26s %14s │\n", host, ip }

printf "╰───────────────────────────────────────────╯\n"
