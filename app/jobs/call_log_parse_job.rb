class CallLogParseJob
  include Resque::Plugins::Status

  def perform
    call_log = CallLog.find options['call_log_id']
    call_log.extract_actions
  end

end
