do ($ = jQuery) ->
  $.fn.textSearch = (query) ->

    q = $.trim(query.replace(/\+/g, ' ').replace(/\s+/g, ' ')).split ' '

    if !q?.length
      return

    @each ->
      e = $ @

      html = e.html().replace /<!--[\s\S]*?-->/g, '' #delete all notes

      #reset
      e.find 'span.mark'
      .each ->
        elem = $ @
        elem.replaceWith elem.text()

      for a in q
        reg = new RegExp '(>[^<"\']*?)(' + a + ')([^>"\']*?<)', 'gi'
        if reg.test html
          html = html.replace reg, '$1<span class="mark">$2</span>$3'

      e.html html