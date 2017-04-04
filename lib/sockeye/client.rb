require 'json'
require 'websocket-eventmachine-client'

module Sockeye
  class Client

    attr_accessor :server_address, :auth_token, :on_message, :on_error, :on_close

    def initialize(server_address:, auth_token:, on_message:, on_error:, on_close:)
      self.server_address = server_address
      self.auth_token = auth_token
      self.on_message = on_message
      self.on_error = on_error
      self.on_close = on_close
    end

    def connect

      EM.run do

        ws = WebSocket::EventMachine::Client.connect(uri: self.server_address)

        ws.onopen do
          ws.send({action: :authenticate, payload: self.auth_token}.to_json)
        end

        # When a message is received, ensure the server sent a valid payload
        # then handle it based on status code.
        #
        ws.onmessage do |msg, type|
          message = json_try_parse(msg)
          puts message.inspect
          if message.nil? || message[:payload].nil? || message[:status].nil?
            puts "Invalid message"
            self.on_error.call
            ws.close
          elsif message[:status] != 200
            self.on_error.call(message[:status])
          else
            self.on_message.call(message[:payload])
          end
        end

        ws.onclose do
          self.on_close.call
          EM.stop
        end

        ws.onerror do
          self.on_error.call(0)
          ws.close
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
