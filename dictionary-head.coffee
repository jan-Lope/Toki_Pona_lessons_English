getRandomEntry = ->
  dictionary[Math.floor Math.random() * dictionary.length]

filterEntry = (exp, prefix='') ->
  try re = new RegExp "#{prefix}#{exp.trim()}" catch then return -> false
  return (entry) -> re.test(entry.tokipona) or re.test(entry.english)

search = (exp) ->
  if !exp then return []
  exactMatches = dictionary.filter filterEntry exp, '^'
  otherMatches = dictionary.filter((e) -> e not in exactMatches).filter filterEntry exp
  return exactMatches.concat(otherMatches)[...100]

setSearchResults = ->
  results = search document.getElementById('search').value
  document.getElementById('results').innerHTML = results.map((e) -> "#{e.tokiponaHTML} :: #{e.englishHTML}").join '<br />'

setSearchValue = (text) ->
  document.getElementById('search').value = text
  setSearchResults()

selectable = (text) ->
  text.replace /[A-Za-z]+/g, (word) -> """
    <a onclick='tokipona.setSearchValue("#{word}")'>#{word}</a>
  """

#
#
#
onclickRandomState = null

pickQuestionAndAnswer = ->
  if !onclickRandomState
    entry = getRandomEntry()

    [q, a] = if Math.random() > .5 then ['tokipona', 'english'] else ['english', 'tokipona']
    onclickRandomState =
      question: entry[q+'HTML']
      answer: entry[a+'HTML']

    document.getElementById('question').innerHTML = onclickRandomState.question
    document.getElementById('answer').innerHTML = '?'

  else
    document.getElementById('answer').innerHTML = onclickRandomState.answer
    onclickRandomState = null

#
#
#
window.tokipona = {pickQuestionAndAnswer, setSearchResults, setSearchValue}

#
#
#
dictionary = '''
