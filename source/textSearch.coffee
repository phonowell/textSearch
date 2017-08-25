do ($ = jQuery or Zepto) ->

  fn = (queryString) ->

    qs = queryString
    .replace /\+/g, ' '
    .replace /\s+/g, ' '
    qs = $.trim qs

    listQuery = qs.split ' '

    if !listQuery?.length then return

    @each ->

      $el = $ @

      html = $el.html().replace /<!--[\s\S]*?-->/g, '' # delete all notes

      # reset html

      $el.find 'span.mark'
      .each ->

        $mark = $ @
        $mark.replaceWith $mark.text()

      # search & replace

      for key in listQuery

        reg = new RegExp '(>[^<"\']*?)(' + key + ')([^>"\']*?<)', 'gi'

        if !reg.test html then continue

        html = html.replace reg, '$1<span class="mark">$2</span>$3'

      # output

      $el.html html

  # return
  $.fn.textSearch = fn
