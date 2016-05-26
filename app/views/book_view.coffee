$ ->
  class ReadingList.BookView extends Backbone.View
    tagName: 'div',
    className: 'book'

    template: ReadingList.App.templates['book']

    events:
     'click span.book-edit': 'edit'
     'dblclick div.book-content': 'edit'
     'click span.book-destroy': 'clear'
     'click button.edit-book': 'close'

    initialize: ->
      @model.view = this

    render: ->
      @$el.html(@template(@model.toJSON()))
      @

    clear: ->
      @model.clear()

    edit: ->
      @$el.addClass('editing')

    close: ->
      @model.save({
        author: this.$('.edit-book-author').val(),
        title: this.$('.edit-book-title').val()
      })

      @$el.removeClass('editing')
      @render()

