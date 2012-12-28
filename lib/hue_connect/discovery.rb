require 'socket'
require 'timeout'
require 'net/http'

module HueConnect
  class Discovery

    SSDP_ADDR = '239.255.255.250'
    SSDP_PORT = 1900
    M_SEARCH = "M-SEARCH * HTTP/1.1\r\nHOST: #{SSDP_ADDR}:#{SSDP_PORT}\r\nMAN: \"ssdp:discover\"\r\nMX: 2\r\nST: ssdp:all\r\n\r\n"
    MAX_RECEIVE_LENGTH = 65536

    # Signal the uPnP Multicast address and wait for responses, returning an array of SimpleUpnp::Devices
    def self.search(seconds_to_listen=5)
      socket = UDPSocket.new
      socket.bind('', SSDP_PORT)
      socket.setsockopt(Socket::IPPROTO_IP, Socket::IP_TTL, [1].pack('i'))
      socket.send(M_SEARCH, 0, SSDP_ADDR, SSDP_PORT)
      process_messages(socket, seconds_to_listen)
    end

    private

    # Read responses from the socket until the timeout triggers or we have found a Hub
    def self.process_messages(socket, seconds_to_listen)
      begin
        Timeout::timeout(seconds_to_listen) do
          while true
            message, sender = socket.recvfrom(MAX_RECEIVE_LENGTH)
            location = get_location(message)
            return sender[2] if location and is_hub(location)
          end
        end
      rescue Timeout::Error => e
        # Finished Listening
        return nil
      ensure
        socket.close
      end
    end

    # Parse out the XML Description File Location from the uPnP headers
    def self.get_location(message)
      lines = message.split(/\r?\n/)
      lines.each do |line|
        if line =~ /^LOCATION:/i
          return line.split(': ')[1]
        end
      end
      return nil
    end

    # Get the XML Description File and check if Philips hue is mentioned
    def self.is_hub(location)
      url = URI.parse(location)
      req = Net::HTTP::Get.new(url.path)
      res = Net::HTTP.start(url.host, url.port) {|http| http.request(req) }
      return res.body =~ /Philips hue/
    end

  end
end