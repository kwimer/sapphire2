$ ->
  autosize($('textarea'))
  setupAutoComplete()
  Filterrific.init()
  $('#search_field').on 'change', ->
    $(@).parents('form').submit()

window.setupAutoComplete = ->
  $('[data-url]').each ->
    input = $(@)
    multi = input.attr('multiple')
    data = input.data('data')
    input.addClass('dropdown-arrow') if data
    options = input.data('data') || {}
    input.selectize
      dropdownParent: 'body'
      plugins: if multi then ['silent_remove', 'remove_button'] else ['silent_remove']
      mode: if multi then 'multiple' else 'single'
      openOnFocus: if data then true else false
      closeAfterSelect: true
      highlight: false
      valueField: 'id'
      labelField: 'name'
      searchField: 'name'
      render:
        option: (item, escape) ->
          """<div class="media my-1 #{if item.imported then 'imported' else ''}"><img class="mr-2" src="#{item.image}" style="width:30px;height:45px;"><div class="media-body py-1"><div><strong>#{item.name}</strong></div><small>#{item.description}</small></div></div>"""
      score: ->
        ->
          return 1
      onInitialize: ->
        self = @
        @.$control_input.attr('autocomplete', 'nothing')
        self.options = self.sifter.items = options
      onChange: (value) ->
        self = @
        item = self.options[value]
        self.options = self.sifter.items = options
      onItemAdd: ->
        self = @
        self.loadedSearches = {}
        self.userOptions = {}
        self.renderCache = {}
        self.lastQuery = null
      onDelete: ->
        self = @
        self.loadedSearches = {}
        self.userOptions = {}
        self.renderCache = {}
        self.options = self.sifter.items = options
        self.lastQuery = null
      load: (query, callback) ->
        self = @
        self.loadedSearches = {}
        self.userOptions = {}
        self.renderCache = {}
        self.options = self.sifter.items = options
        self.lastQuery = null
        if !query.length || query == ''
          callback([])
        else
          url = input.data('url')
          join = if /\?/.test(url) then '&' else '?'
          $.ajax
            url: """#{url}#{join}q=#{encodeURIComponent(query)}"""
            type: 'GET'
            error: ->
              callback([])
            success: (results) ->
              self.options = self.sifter.items = {}
              callback(results)

#    hackToClose = false;
#    input.on 'item_remove', (value, $item) ->
#      hackToClose = true
#    input.on 'dropdown_open', ($dropdown) ->
#      if hackToClose
#        input.close()
#      hackToClose = false