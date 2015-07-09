require "logstash/filters/base"
require "logstash/namespace"
class LogStash::Filters::Exec < LogStash::Filters::Base
  config_name "exec"

  default :codec, "plain"

  # Set this to true to enable debugging on an input.
  config :debug, :validate => :boolean, :default => false, :deprecated => "This setting was never used by this plugin. It will be removed soon."

  # Command to run. For example, `uptime`
  config :command, :validate => :string, :required => true

  # Command to run. For example, `uptime`
  config :target, :validate => :string, :required => true

  public
  def register
    @logger.info("Registering Exec Custom Filter")
  end

  public
  def filter(event)
    # return nothing unless there's an actual filter event
    return unless filter?(event)

    result = `#{command}`
    retCode = $?.exitstatus

    if retCode == 0
      event[@target] = result.strip
    else
      event[@target] = "error #{retCode}: #{result.strip}"
    end

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end
end
