$ ->
  class ReadingList.BookList extends Backbone.Collection
    model: ReadingList.Book

    localStorage: new Backbone.LocalStorage("readinglist")

    getRead: (book) ->
      book.get("read")

    finished: ->
      @filter(getRead)

    toRead: ->
      @without.apply(this, @finished())

    comparator: (book) ->
      book.get('order')
