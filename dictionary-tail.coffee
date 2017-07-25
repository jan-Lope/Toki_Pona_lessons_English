  [tokipona, english] = w.split '::'
  return entry =
    tokipona: tokipona.trim()
    english: english.trim()
    tokiponaHTML: selectable tokipona
    englishHTML: selectable english


