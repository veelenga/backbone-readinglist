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
      @books.fetch()

      @books.add(options.predefined) if @books.size() < 1

    addOne: (book) =>
      view = new ReadingList.BookView({ model: book })
      this.$('#books').append( view.render().el )

    addBook: (e) ->
      @books.create({
        author: @bookAuthor.val(),
        title: @bookTitle.val(),
        read: false
      }, {wait: true})
      @bookAuthor.val('')
      @bookTitle.val('')
