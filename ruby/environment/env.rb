# frozen_string_literal: true
require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

CONN = PG.connect(dbname: 'users', user: 'postgres', password: 'postgres')
CONN.type_map_for_results = PG::BasicTypeMapForResults.new(CONN)
