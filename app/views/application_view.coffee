$ ->
  class ReadingList.ApplicationView extends Backbone.View
    el: '#readinglist'
    template: ReadingList.App.templates['application']

    initialize: (options = {}) ->
      @render()

    render: ->
      @$el.html @template(data: 'It works')
