require './lib/maki'

maki = Maki.new
hear %r{(まき|真姫|)ちゃ(ん|ーん)} do |e|
  case e.text
  when /.*すごい/
    say maki.talk('てれ'), channel: e.channel
  when /.*(かわ|可愛)いい/
    say maki.talk('かわいい'), channel: e.channel
  when /.*(筋肉|きんにく|muscle|Muscle)/
    say maki.talk('きんにく'), channel: e.channel
  when /.*クラシック/
    classic_songs.each { |song| say maki(song), channel: e.channel }
    say 'とかがいいんじゃない？', channel: e.channel
  else
    # FIXME: ネガポジ判定Gemを入れてその内容に合わせて返事を抽選
    say maki.talk('その他'), channel: e.channel
  end
end

hear %r{.*(うーん|しんどい|疲れた|つかれた)} do |e|
  say maki.talk('しんぱい'), channel: e.channel
end

# FIXME: これは必ずクラス化してライフサイクルを与えるべき
hear /.*/ do |e|
  if maki.librarian?
    maki.add_note(e.text)
  end
end

hear %r{(メモ|ノート).*(して|取って|とって)} do |e|
  say 'メモするわね', channel: e.channel
  maki.start_note
end

hear %r{(ノート|メモ).*(終わり|ここまで)} do |e|
  maki.save_note!
  maki.to_bot
  say 'メモ書いたわよ', channel: e.channel
end

hear %r{最後のメモ} do |e|
  say maki.last_note.text, channel: e.channel
end
