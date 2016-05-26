window.ReadingList = {}

ReadingList.App = {
  init: (options = {}) ->

    $(document).ready ->
      new ReadingList.ApplicationView(options)
}
