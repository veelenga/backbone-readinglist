$ ->
  class ReadingList.Book extends Backbone.Model
    defaults:
      read: false
      stars: 0

    toggle_read: ->
      @save({ read: !@get("read") })

    clear: ->
      @destroy()
      @view.remove()
