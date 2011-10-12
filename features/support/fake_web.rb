class FakeWeb
  class << self
    def call(env)
      stubbed_request = @stubbed_requests.find do |a|
        a[0] =~ /#{Regexp.escape(env['SERVER_NAME'])}/
      end

      if stubbed_request
        [stubbed_request[1][:code], {'Content-Type' => 'text/html'}, ['']]
      else
        raise "unknown domain #{env['SERVER_NAME']} for fake web"
      end
    end

    def stub_request(url, opts = {})
      @stubbed_requests ||= []
      @stubbed_requests << [url, opts]
    end
  end
end