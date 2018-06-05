class Log
  attr_reader :type, :emotion, :event, :replied
  def initialize(params)
    @type = params[:type] || 'json'
    @emotion = params[:emotion]
    @event = params[:event]
    @replied = params[:replied] || true
  end

  def write
    log = format
    File.open(export_path, 'a') do |f|
      f.puts(log)
    end
    Logger.new(STDOUT).info(log)
  end

  private

  def export_path
    "./logs/#{Time.now.strftime('%Y-%m-%d')}.#{type}"
  end

  def format
    JSON.generate(
      {
        channel: event.data.channel,
        replied: replied,
        emotion: emotion,
        message: event.text,
      }
    )
  end
end
