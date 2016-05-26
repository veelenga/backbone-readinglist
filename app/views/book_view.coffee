$ ->
  class ReadingList.BookView extends Backbone.View
    tagName: 'li'

    template: ReadingList.App.templates['book']

    initialize: ->
      @model.bind('change', this.render)
      @model.view = this

    render: =>
      @$el.html(@template(@model.toJSON()))
      @setContent()
      @

    setContent: ->
      author = @model.get("author")
      title = @model.get("title")
      this.$('.book-content').text("#{author} - #{title}")
