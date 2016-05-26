(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  $(function() {
    return ReadingList.Book = (function(superClass) {
      extend(Book, superClass);

      function Book() {
        return Book.__super__.constructor.apply(this, arguments);
      }

      Book.prototype.defaults = {
        read: false,
        stars: 0
      };

      Book.prototype.toggle_read = function() {
        return this.save({
          read: !this.get("read")
        });
      };

      Book.prototype.clear = function() {
        this.destroy();
        return this.view.remove();
      };

      return Book;

    })(Backbone.Model);
  });

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  $(function() {
    return ReadingList.BookList = (function(superClass) {
      extend(BookList, superClass);

      function BookList() {
        return BookList.__super__.constructor.apply(this, arguments);
      }

      BookList.prototype.model = ReadingList.Book;

      BookList.prototype.localStorage = new Backbone.LocalStorage("readinglist");

      BookList.prototype.getRead = function(book) {
        return book.get("read");
      };

      BookList.prototype.finished = function() {
        return this.filter(getRead);
      };

      BookList.prototype.toRead = function() {
        return this.without.apply(this, this.finished());
      };

      BookList.prototype.comparator = function(book) {
        return book.get('order');
      };

      return BookList;

    })(Backbone.Collection);
  });

}).call(this);

(function() {
  var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  $(function() {
    return ReadingList.ApplicationView = (function(superClass) {
      extend(ApplicationView, superClass);

      function ApplicationView() {
        this.addOne = bind(this.addOne, this);
        return ApplicationView.__super__.constructor.apply(this, arguments);
      }

      ApplicationView.prototype.el = '#readinglist-app';

      ApplicationView.prototype.template = ReadingList.App.templates['application'];

      ApplicationView.prototype.events = {
        'click button#add-book': 'addBook'
      };

      ApplicationView.prototype.initialize = function(options) {
        if (options == null) {
          options = {};
        }
        this.bookAuthor = this.$('#book-author');
        this.bookTitle = this.$('#book-title');
        this.books = new ReadingList.BookList();
        this.books.bind('add', this.addOne);
        this.books.fetch();
        if (this.books.size() < 1) {
          return this.books.add(options.predefined);
        }
      };

      ApplicationView.prototype.addOne = function(book) {
        var view;
        view = new ReadingList.BookView({
          model: book
        });
        return this.$('#books').append(view.render().el);
      };

      ApplicationView.prototype.addBook = function(e) {
        this.books.create({
          author: this.bookAuthor.val(),
          title: this.bookTitle.val(),
          read: false
        }, {
          wait: true
        });
        this.bookAuthor.val('');
        return this.bookTitle.val('');
      };

      return ApplicationView;

    })(Backbone.View);
  });

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  $(function() {
    return ReadingList.BookView = (function(superClass) {
      extend(BookView, superClass);

      function BookView() {
        return BookView.__super__.constructor.apply(this, arguments);
      }

      BookView.prototype.tagName = 'div';

      BookView.prototype.className = 'book';

      BookView.prototype.template = ReadingList.App.templates['book'];

      BookView.prototype.events = {
        'click span.book-edit': 'edit',
        'dblclick div.book-content': 'edit',
        'click span.book-destroy': 'clear',
        'click button.edit-book': 'close'
      };

      BookView.prototype.initialize = function() {
        return this.model.view = this;
      };

      BookView.prototype.render = function() {
        this.$el.html(this.template(this.model.toJSON()));
        return this;
      };

      BookView.prototype.clear = function() {
        return this.model.clear();
      };

      BookView.prototype.edit = function() {
        return this.$el.addClass('editing');
      };

      BookView.prototype.close = function() {
        this.model.save({
          author: this.$('.edit-book-author').val(),
          title: this.$('.edit-book-title').val()
        });
        this.$el.removeClass('editing');
        return this.render();
      };

      return BookView;

    })(Backbone.View);
  });

}).call(this);

(function() {
  window.ReadingList = {};

  ReadingList.App = {
    init: function(options) {
      if (options == null) {
        options = {};
      }
      return $(document).ready(function() {
        return new ReadingList.ApplicationView(options);
      });
    }
  };

}).call(this);

this["ReadingList"] = this["ReadingList"] || {};
this["ReadingList"]["App"] = this["ReadingList"]["App"] || {};
this["ReadingList"]["App"]["templates"] = this["ReadingList"]["App"]["templates"] || {};

this["ReadingList"]["App"]["templates"]["book"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<li class="list-group-item">\n\n  <div class="book-content">\n    ' +
__e( author ) +
' - ' +
__e( title ) +
'\n    <span class="fa fa-trash pull-right fa-lg book-destroy"></span>\n    <span class="fa fa-pencil pull-right fa-fw book-edit"></span>\n  </div>\n\n  <div class="book-edit">\n    <div class="form-inline row">\n      <div class="form-group col-md-5 col-sm-5">\n        <input class="form-control edit-book-author" value="' +
__e( author ) +
'" type="text" autofocus />\n      </div>\n      <div class="form-group col-md-5 col-sm-5">\n        <input class="form-control edit-book-title" value="' +
__e( title ) +
'" type="text" />\n      </div>\n      <div class="col-md-2">\n        <button class="btn btn-warning edit-book" type="submit">Save</button>\n      </div>\n    </div>\n  </div>\n\n</li>\n';

}
return __p
};