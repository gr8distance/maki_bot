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

def deliver(regex, emotion)
  hear regex do |e|
    channel = reply(e)
    say Serif.lottery_weight(emotion).text, channel: channel
    Log.create!(channel: e.data.channel, message: e.text, tag: emotion)
  end
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

conditions = {
  'しんぱい' => %r{.*(うーん|しんどい|疲れた|つかれた)},
  'おつかれ' => %r{(帰る|かえる)},
  'はなよ' => %r{(ラブライス|お米|ご飯|ごはん|おこめ)},
  'ねむい' => '(眠|ねむ)い'
}
conditions.each do |k, v|
  deliver(v, k)
end

hear %r{巻ちゃん} do |e|
  channel = reply(e)
  say 'ショッ!', channel: channel
  say 'ッテ、何言ワセンノヨ！', channel: channel
end
