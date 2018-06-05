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
  return event.channel if active_channels.include?(event.data.channel)
end

# FIXME: そのうちログファイルに書き出す
def create_log(event, replied)
  {
    channel: event.data.channel,
    message: event.text,
    replied: replied
  }
end

def branch_emotion(event)
  case event.text
  when /.*(すごい|天才|てんさい)/
    'てれ'
  when /.*(かわ|可愛)いい/
    'かわいい'
  when /.*(筋肉|きんにく|muscle|Muscle)/
    'きんにく'
  else
    'その他'
  end
end

hear %r{(まき|真姫)ちゃ(ん|ーん)} do |e|
  channel = reply(e)
  replied = false
  unless channel.nil?
    emotion = branch_emotion(e)
    say Serif.lottery_weight(emotion).text, channel: channel
    Log.create!(channel: channel, tag: emotion, message: e.text)
    replied = true
  end
  logger.info(create_log(e, replied))
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

hear %r{巻ちゃん} do |e|
  channel = reply(e)
  say 'ショッ!', channel: channel
  say 'ッテ、何言ワセンノヨ！', channel: channel
end
