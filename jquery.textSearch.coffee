do ($ = jQuery) ->
  $.fn.textSearch = (string, callback) ->

    #check string
    s = $.trim string
    .replace /\+/g, ' '
    .replace /\s+/g, ' '

    if !s
      return

    #make list
    list = s.split ' '

    #each
    @each ->
      e = $ @
      html = e.html()
      #delete all notes of html
      .replace /<!--[\s\S]*?-->/g, ''

      #reset
      e.find 'span.mark'
      .each ->
        elem = $ @
        elem.replaceWith elem.text()

      #for
      for a in list
        reg = new RegExp '(>[^<"\']*?)' + a + '([^>"\']*?<)', 'g'
        if reg.test html
          html = html
          .replace reg, '$1<span class="mark">' + a + '</span>$2'

      #rewrite
      e.html html

    #callback
    callback?()