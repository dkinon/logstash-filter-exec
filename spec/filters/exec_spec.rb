require 'spec_helper'
require "logstash/filters/exec"

describe LogStash::Filters::Exec do
  describe "Set to Hello World" do
    let(:config) do <<-CONFIG
      filter {
        exec {
          command => "echo working"
          target => "is_it_working"
        }
      }
    CONFIG
    end

    sample("message" => "some text") do
      expect(subject).to include("message")
      expect(subject['message']).to eq('Hello World')
    end
  end
end
