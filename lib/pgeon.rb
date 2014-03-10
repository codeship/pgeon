require "pg"
require "ostruct"

module Pgeon
  extend Config

  def self.config
    @config = OpenStruct.new
    yield @config
  end

  def self.fly database_adapter: PG
    @connection = database_adapter.connect host: @config.database_host, dbname: @config.database_name

    # untested
    while true
      @connection.exec "LISTEN testdata;"
      @connection.wait_for_notify(1000) do |event, pid, payload|
        puts "#{event} | #{pid} | #{payload}"
      end
      @connection.exec "UNLISTEN testdata;"
    end
  end

  def self.land
    @connection.close
  end

  def self.invoke
    puts __FILE__
  end
end
