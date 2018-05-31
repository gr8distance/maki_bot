require './lib/models/serif'
require './lib/models/tag'

# FIXME: もしかしたらいらないかもしれないのでそのときは消す
class String
  def to_kana
    tr('ぁ-ん', 'ァ-ン')
  end
end

def maki(*word)
  if word.empty?
    '从廿_廿从'
  else
    '从廿_廿从' + ' < ' + word.join('、')
  end
end

def tags
  @tags ||= Tag.all
end

def classic_songs
  %w[愛の夢 月の光 月光 雨だれ Etude25-10]
end

hear %r{(まき|真姫|)ちゃ(ん|ーん)} do |e|
  case e.text
  when /.*すごい/
    tag = tags.find_by(id: 'てれ')
    say maki(Weight::Lottery.execute(tag.serifs).text), channel: e.channel
  when /.*(かわ|可愛)いい/
    tag = tags.find_by(id: 'かわいい')
    say maki(Weight::Lottery.execute(tag.serifs).text), channel: e.channel
  when /.*(筋肉|きんにく|muscle|Muscle)/
    tag = tags.find_by(id: 'きんにく')
    say maki(Weight::Lottery.execute(tag.serifs).text), channel: e.channel
  when /.*クラシック/
    classic_songs.each { |song| say maki(song), channel: e.channel }
    say maki('とかがいいんじゃない？'), channel: e.channel
  else
    say maki('ゔぇえ', 'な', 'なによー'), channel: e.channel
  end
end

hear /うーん/ do |e|
  say maki('いみわかんない！'.to_kana), channel: e.channel
end
