# frozen_string_literal: true

require "openssl"
require "optparse"
require "uri"

module OpenSearch
  class CLI < OptionParser
    VERSION = "1.0.0"

    def initialize(banner = nil, width = 32, indent = " " * 4, &block)
      @opensearch_options = {
        host: "https://localhost:9200",
        transport_options: {ssl: {}}
      }
      super {}

      add_opensearch_options

      yield(self) if block
    end

    def client
      require "opensearch"
      @client ||= OpenSearch::Client.new(@opensearch_options)
    end

    private

    def add_opensearch_options
      separator("")
      separator("OpenSearch options:")
      on("-u", "--url=URL", "URL of the OpenSearch instance") do |url|
        @opensearch_options[:host] = URI(url)
      end
      on("--cacert=CERTIFICATE", "Verify certificate against the provided CERTIFICATE") do |filename|
        @opensearch_options[:transport_options][:ssl][:ca_file] = filename
      end
      on("--cert=CERTIFICATE", "Use the provided CERTIFICATE for TLS client authentication") do |filename|
        @opensearch_options[:transport_options][:ssl][:client_cert] = OpenSSL::X509::Certificate.new(File.read(filename))
      end
      on("--key=KEY", "Use the provided KEY for TLS client authentication") do |filename|
        @opensearch_options[:transport_options][:ssl][:client_key] = OpenSSL::PKey.read(File.read(filename))
      end
      on("-k", "--insecure", "Skip certificate verification against trust store") do
        @opensearch_options[:transport_options][:ssl][:verify] = false
      end
      on("-u", "--user=USER[:PASSWORD]", "Specify the user name and password to use for authentication") do |user_pass|
        @opensearch_options[:user], @opensearch_options[:password] = user_pass.split(":", 2)
        if @opensearch_options[:password].nil?
          require "io/console"

          print "Enter password for user '#{@opensearch_options[:user]}': "
          @opensearch_options[:password] = $stdin.noecho(&:gets)&.chomp!
        end
      end
      on("-v", "--verbose", %(Show what's going on "under the hood")) do
        @opensearch_options[:log] = true
      end
    end
  end
end
