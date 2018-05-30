class String
  def to_kana
    tr('ぁ-ん', 'ァ-ン')
  end
end

def maki(*word)
  if word.empty?
    '从廿_廿从'
  else
    '从廿_廿从' + ' < ' + word.join('、').to_kana
  end
end

class Team
  def initialize
    @name = ''
  end
end

hear %r{(まき|真姫|)ちゃ(ん|ーん)$} do |event|
  say maki('なによー'), channel: event.channel
end

hear %r{(まき|まきちゃん|西木野真姫).*(かわ|可愛)いい} do |event|
  say maki('あたりまえでしょ！'), channel: event.channel
end

hear /うーん/ do |e|
  say maki('いみわかんない！'), channel: e.channel
end

hear /筋肉/ do |e|
  say maki('イミワカンナい', 'きもちわるい'), channel: e.channel
end

# # use regexp in string literal
# hear 'bar (.*)' do |event|
#   puts event.matches[1] #=> Event#matches return MatchData object
# end
#
#
# # event object is slack event JSON (convert to Hashie::Mash)
# hear '^bar (.*)' do |event|
#   puts event.channel #=> channel id
#   say 'slappy!', channel: event.channel #=> to received message channel
#   say 'slappy!', channel: '#general'
#   say 'slappy!', username: 'slappy!', icon_emoji: ':slappy:'
# end
#
#
# # use regexp literal
# hear /^foobar/ do
#   say 'slappppy!'
# end
