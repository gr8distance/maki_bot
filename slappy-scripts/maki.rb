require './lib/models/serif'
require './lib/models/log'
require './lib/models/active_channel'
require './lib/string'

hello do
  logger.info '起きたわよ'
end

def active_channels
  @active_channels ||= ActiveChannel.all.pluck(:id)
end

def reply(event)
  if active_channels.include?(event.data.channel)
    event.channel
  else
    ENV['DEFAULT_CHANNEL']
  end
end

hear %r{(まき|真姫)ちゃ(ん|ーん)} do |e|
  channel = reply(e)
  tag = case e.text
        when /.*(すごい|天才|てんさい)/
          'てれ'
        when /.*(かわ|可愛)いい/
          'かわいい'
        when /.*(筋肉|きんにく|muscle|Muscle)/
          'きんにく'
        else
          'その他'u
        end
  say Serif.lottery_weight(tag).text, channel: channel
  Log.create!(channel: e.data.channel, message: e.text, tag: tag)
end

hear %r{.*(うーん|しんどい|疲れた|つかれた)} do |e|
  channel = reply(e)
  say Serif.lottery_weight('しんぱい').text, channel: channel
  Log.create!(channel: e.data.channel, message: e.text, tag: 'しんぱい')
end

hear %r{(帰る|かえる)} do |e|
  channel = reply(e)
  say Serif.lottery_weight('おつかれ').text, channel: channel
  Log.create!(channel: e.data.channel, message: e.text, tag: 'おつかれ')
end

hooks = '(眠|ねむ)い'
hear %r{#{hooks}} do |e|
  channel = reply(e)
  say Serif.lottery_weight('通常').text, channel: channel
  Log.create!(channel: e.data.channel, message: e.text, tag: '通常')
end
