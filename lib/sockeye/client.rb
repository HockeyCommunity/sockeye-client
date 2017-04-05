require 'json'
require 'websocket-eventmachine-client'

module Sockeye
  class Client

    attr_accessor :server_address, :auth_token, :on_message, :on_error, :on_close

    def initialize(server_address:, auth_token:, on_message: nil, on_error: nil, on_close: nil)
      self.server_address = server_address
      self.auth_token     = auth_token
      self.on_message     = on_message || Proc.new { |payload| nil }
      self.on_error       = on_error   || Proc.new { |payload| nil }
      self.on_close       = on_close   || Proc.new { nil }
    end

    @raw_socket = nil 

    def close
      @raw_socket.close
      EM.stop
    end

    def connect

      EM.run do

        @raw_socket = WebSocket::EventMachine::Client.connect(uri: self.server_address)

        @raw_socket.onopen do
          @raw_socket.send({action: :authenticate, payload: self.auth_token}.to_json)
        end

        # When a message is received, ensure the server sent a valid payload
        # then handle it based on status code.
        #
        @raw_socket.onmessage do |msg, type|
          message = json_try_parse(msg)
          if message.nil? || message[:payload].nil? || message[:status].nil?
            puts "Invalid message"
            self.on_error.call
            ws.close
          elsif message[:status].to_i >= 400 || message[:status].to_i == 0
            self.on_error.call(message)
          else
            self.on_message.call(message)
          end
        end

        @raw_socket.onclose do
          self.on_close.call
          EM.stop
        end

        @raw_socket.onerror do
          self.on_error.call(0)
          @raw_socket.close
          EM.stop
        end

      end

    end

    private

    def json_try_parse(data)
      begin
        return JSON.parse(data, symbolize_names: true)
      rescue JSON::ParserError => e
        return nil
      end
    end

  end
end
