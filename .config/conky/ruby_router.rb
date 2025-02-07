#!/usr/bin/env ruby
require "json"
require "net/http"
require "uri"

VARIABLES = %i(
  signalbar
  battery_charging
  battery_vol_percent
  realtime_tx_bytes
  realtime_rx_bytes
  realtime_tx_thrpt
  realtime_rx_thrpt
  monthly_rx_bytes
  monthly_tx_bytes
)

def fetch_stats!
  res = Net::HTTP.get(
    URI::HTTP.build(
	    host: "192.168.0.1",
	    path: "/goform/goform_get_cmd_process",
	    query: URI.encode_www_form(
	      multi_data: 1,
	      cmd: VARIABLES.join(","),
	    ),
	  ),
    Referer: "http://192.168.0.1/index.html",
  )
  stats = JSON.parse(res)
end

RouterStats = Struct.new(*VARIABLES) do
  def self.fetch!
    new(*fetch_stats!.values.map(&:to_i))
  end

  def charging?
    battery_charging == 1
  end

  def monthly_total
    monthly_rx_bytes + monthly_tx_bytes
  end

  def realtime_total
    realtime_rx_bytes + realtime_tx_bytes
  end

  def realtime_GiB
    format "%.3f GiB", realtime_total.fdiv(2 ** 30)
  end

  def monthly_GiB
    format "%.3f GiB", monthly_total.fdiv(2 ** 30)
  end

  def monthly_usage_percent
    format "%.3f%%", monthly_total.fdiv(2 ** 30) / 30 * 100
  end
end

pp stats = RouterStats.fetch!
puts "---------------"
for method in RouterStats.instance_methods(false)
  next if method.end_with? '='
  printf "%22s => %p\n", method, stats.send(method)
end
puts "---------------"
