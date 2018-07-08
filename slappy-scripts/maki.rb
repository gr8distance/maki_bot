require './lib/models/serif'
require './lib/log'
require './lib/models/active_channel'
require './lib/string'

hello do
  logger.info '起きたわよ'
end

def reply(event)
  # NOTE: なんか条件を付ける必要が出たときはそれに合わせて対応する
  event.channel
end

def deliver(regex, emotion)
  hear regex do |e|
    channel = reply(e)
    say Serif.lottery_weight(emotion).text, channel: channel
    Log.new(emotion: emotion, event: e).write
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
    replied = true
  end
  Log.new(emotion: emotion, event: e, replied: replied).write
end

conditions = {
  'しんぱい' => %r{.*(うーん|しんどい|疲れた|つかれた)},
  'おつかれ' => %r{(帰る|かえる)},
  'はなよ' => %r{(ラブライス|お米|ご飯|ごはん|おこめ)},
  'ねむい' => '(眠|ねむ)い',
}
conditions.each do |k, v|
  deliver(v, k)
end

hear %r{巻ちゃん} do |e|
  channel = reply(e)
  say 'ショッ!', channel: channel
  say 'ッテ、何言ワセンノヨ！', channel: channel
  Log.new(emotion: '巻ちゃん', event: e).write
end

hear %r{ちゃんまき} do |e|
  channel = reply(e)
  say Serif.lottery_weight('おこ').text, channel: channel
  Log.new(emotion: 'おこ', event: e).write
end

hear %r{チャンスなのでは} do |e|
  channel = reply(e)
  say 'そうね、それでやってみるといいんじゃない？', channel: channel
  Log.new(emotion: 'チャンス', event: e).write
end

hear %r{お腹空いた} do |e|
  channel = reply(e)
  say Time.now.strftime('%Y-%m-%d %H:%M'), channel: channel
  Log.new(emotion: 'くうふく', event: e).write
end
