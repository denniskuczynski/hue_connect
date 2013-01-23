module HueConnect
  class Discovery

    def self.find_hub
      hub_device = nil
      SimpleUpnp::Discovery.find do |device|
        if is_hue?(device)
          hub_device = device
          break
        end
      end
      return get_ip(hub_device) if hub_device
      return nil
    end

    private

    def self.is_hue?(device)
      include_location_details = true
      device_json = device.to_json(include_location_details)
      friendly_name = get_friendly_name(device_json)
      return friendly_name =~ /Philips hue/
    end

    def self.get_friendly_name(device_json)
      if device_json['root']
        if device_json['root']['device']
          if device_json['root']['device']['friendlyName']
            return device_json['root']['device']['friendlyName']     
          end
        end
      end
      nil
    end

    def self.get_ip(hub_device)
      location = hub_device.location
      port_index = location.rindex(':') - 1
      return location.slice(7..port_index)
    end

  end
end