require './lib/models/serif'
require './lib/string'

def maki(*word)
  if word.empty?
    '从廿_廿从'
  else
    '从廿_廿从' + ' < ' + word.join('、')
  end
end

def classic_songs
  %w[愛の夢 月の光 月光 雨だれ Etude25-10]
end

@mode ||= 'bot'
@memo ||= Memo.new(body: '')

hear %r{(まき|真姫|)ちゃ(ん|ーん)} do |e|
  case e.text
  when /.*すごい/
    say maki(Serif.lottery_weight('てれ').text), channel: '#times-ymasuo'
  when /.*(かわ|可愛)いい/
    say maki(Serif.lottery_weight('かわいい').text), channel: '#times-ymasuo'
  when /.*(筋肉|きんにく|muscle|Muscle)/
    say maki(Serif.lottery_weight('きんにく').text), channel: '#times-ymasuo'
  when /.*クラシック/
    classic_songs.each { |song| say maki(song), channel: '#times-ymasuo' }
    say maki('とかがいいんじゃない？'), channel: '#times-ymasuo'
  else
    # FIXME: ネガポジ判定Gemを入れてその内容に合わせて返事を抽選
    say maki(Serif.lottery_weight('その他').text), channel: '#times-ymasuo'
  end
end

hear %r{.*(うーん|しんどい|疲れた|つかれた)} do |e|
  say maki(Serif.lottery_weight('しんぱい').text), channel: '#times-ymasuo'
end

# FIXME: これは必ずクラス化してライフサイクルを与えるべき
hear /.*/ do |e|
  if @mode == 'memo'
    @memo.body += (e.text + '\n')
  end
end

hear %r{メモ.*(して|取って|とって)} do |e|
  say maki('メモするわね'), channel: '#times-ymasuo'
  @memo = Memo.new(body: '')
  @mode = 'memo'
end

hear %r{メモ.*(終わり|ここまで)} do |e|
  @memo.save!
  @memo = nil
  @mode = 'bot'
  say maki('メモ書いたわよ'), channel: '#times-ymasuo'
end
