$ ->
  class ReadingList.Book extends Backbone.Model
    defaults:
      read: false
      stars: 0

    validate: (attributes) ->
      unless attributes.author and attributes.title
        return 'Author and title required'

    toggle_read: ->
      @save({ read: !@get("read") })

    clear: ->
      @destroy()
      @view.remove()
