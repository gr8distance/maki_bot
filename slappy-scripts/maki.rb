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

hear %r{(まき|真姫|)ちゃ(ん|ーん)} do |e|
  case e.text
  when /.*すごい/
    tag = tags.find_by(id: 'てれ')
    say maki(Weight::Lottery.execute(tag.serifs).text), channel: e.channel
  when /.*(かわ|可愛)いい/
    tag = tags.find_by(id: 'かわいい')
    say maki(Weight::Lottery.execute(tag.serifs).text), channel: e.channel
  else
    say maki('ゔぇえ', 'な', 'なによー'), channel: e.channel
  end
end

hear /うーん/ do |e|
  say maki('いみわかんない！'), channel: e.channel
end

hear /筋肉/ do |e|
  say maki('イミワカンナい', 'きもちわるい'), channel: e.channel
end
