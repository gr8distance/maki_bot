require './lib/models/serif'
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
  case e.text
  when /.*すごい/
    say Serif.lottery_weight(tag).text, channel: channel
  when /.*(かわ|可愛)いい/
    say Serif.lottery_weight('かわいい').text, channel: channel
  when /.*(筋肉|きんにく|muscle|Muscle)/
    say Serif.lottery_weight('きんにく').text, channel: channel
  else
    # FIXME: ネガポジ判定Gemを入れてその内容に合わせて返事を抽選
    say Serif.lottery_weight('その他').text, channel: channel
  end
end

hear %r{.*(うーん|しんどい|疲れた|つかれた)} do |e|
  channel = reply(e)
  say Serif.lottery_weight('しんぱい').text, channel: channel
end

hear %r{(帰る|かえる)} do |e|
  channel = reply(e)
  say Serif.lottery_weight('おつかれ').text, channel: channel
end

hooks = '(眠|ねむ)い'
hear %r{#{hooks}} do |e|
  channel = reply(e)
  say Serif.lottery_weight('通常').text, channel: channel
end
