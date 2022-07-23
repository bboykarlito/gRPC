require_relative '../environment/env'
require 'pry'
require 'faraday'
require 'faraday/net_http'
require 'json'
require 'benchmark'
Faraday.default_adapter = :net_http

def main
  Benchmark.bm do |op|
  	op.report{
      conn = Faraday.new(
  	    url: 'http://localhost:9292',
  	    headers: {'Content-Type' => 'application/json'}
      )

      response = conn.post('/') do |req|
        req.params['limit'] = 1000
      end
    }
  end
  # JSON.parse(response.body).each do |hash|
  # 	p hash["username"]
  # end
end

main