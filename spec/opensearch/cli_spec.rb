# frozen_string_literal: true

RSpec.describe OpenSearch::CLI do
  it "should have a version number" do
    expect(OpenSearch::CLI::VERSION).not_to be nil
  end

  describe "when given extra options" do
    let(:cli) do
      OpenSearch::CLI.new do |opts|
        opts.separator ""
        opts.separator "Extra options:"
        opts.on("-x", "--extra", "Extra option") do
          @extra = true
        end
      end
    end

    it "should accept OpenSearch options" do
      expect(cli.parse!(%w[--url https://example.com:9200 foo --user bob:secret bar])).to eq(["foo", "bar"])
    end

    it "should generate the expected help" do
      expect(cli.help).to eq(<<~OUTPUT)
        Usage: rspec [options]

        OpenSearch options:
                --url=URL                    URL of the OpenSearch instance
                --cacert=CERTIFICATE         Verify certificate against the provided CERTIFICATE
                --cert=CERTIFICATE           Use the provided CERTIFICATE for TLS client authentication
                --key=KEY                    Use the provided KEY for TLS client authentication
            -k, --insecure                   Skip certificate verification against trust store
            -u, --user=USER[:PASSWORD]       Specify the user name and password to use for authentication
            -v, --verbose                    Show what's going on "under the hood"

        Extra options:
            -x, --extra                      Extra option
      OUTPUT
    end

    it "should parse the extra options" do
      cli.parse! %w[--extra]
      expect(@extra).to be true
    end

    it "should not parse inexistent options" do
      expect { cli.parse! %w[--inexistent] }.to raise_error(OptionParser::InvalidOption)
    end
  end
end
