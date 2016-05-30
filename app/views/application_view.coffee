$ ->
  class ReadingList.ApplicationView extends Backbone.View
    el: '#readinglist-app'
    template: ReadingList.App.templates['application']

    events:
      'click button#add-book': 'addBook'

    initialize: (options = {}) ->
      @bookAuthor = this.$('#book-author')
      @bookTitle = this.$('#book-title')

      @books = new ReadingList.BookList()
      @books.bind('add', @addOne)
      @books.bind('change', (model) ->
        options.onSave.call(@, model.previousAttributes(), model.changed)
      )

      @books.fetch()

      if @books.size() < 1
        _.each(options.predefined, (book) =>
          @books.create(book, { wait: true })
        )

    addOne: (book) =>
      view = new ReadingList.BookView({ model: book })
      this.$('#books').append( view.render().el )

    addBook: (e) ->
      @books.create({
        author: @bookAuthor.val(),
        title: @bookTitle.val(),
        read: false
      }, { wait: true })
      @bookAuthor.val('')
      @bookTitle.val('')
