TASKS = ['jst:compile', 'coffee:compile', 'sass:compile', 'concat:js', 'concat:css', 'clean:compiled', 'uglify:dist']

module.exports = (grunt) ->

  grunt.initConfig
    srcFolder: 'app'
    compiledFolder: 'compiled'
    distFolder: 'dist'
    vendorFolder: 'vendor'

    # grunt jst
    jst:
      compile:
        options:
          namespace: 'ReadingList.App.templates'
          processName: (filename) ->
            folder = "templates/"
            filename.slice(filename.indexOf(folder) + folder.length, filename.indexOf(".html"))
        files:
          '<%= compiledFolder %>/templates.js': '<%= srcFolder %>/templates/**/*.html'

    # grunt coffee
    coffee:
      compile:
        files:
          '<%= compiledFolder %>/readinglist.js': [
            '<%= srcFolder %>/models/*.coffee',
            '<%= srcFolder %>/views/*.coffee',
            '<%= srcFolder %>/main.coffee'
          ]

    # grunt sass
    sass:
      compile:
        options:
          style: 'expanded'
        files:
          '<%= compiledFolder %>/readinglist.css': '<%= srcFolder %>/sass/**.scss'

    # grunt concat
    concat:
      css:
        files:
          '<%= distFolder %>/readinglist.css': '<%= compiledFolder %>/*.css'
      js:
        files:
          '<%= distFolder %>/readinglist.js': '<%= compiledFolder %>/*.js'
          '<%= vendorFolder %>/js/vendor.js': [
            'bower_components/jquery/dist/jquery.js'
            'bower_components/underscore/underscore.js'
            'bower_components/backbone/backbone.js'
            'bower_components/Backbone.localStorage/backbone.localStorage-min.js'
          ]

    # grunt clean
    clean:
      compiled:
        ['<%= compiledFolder %>']

    # grunt uglify
    uglify:
      dist:
        files:
          '<%= distFolder %>/readinglist-min.js': '<%= distFolder %>/readinglist.js'
          '<%= distFolder %>/readinglist_vendor-min.js': '<%= vendorFolder %>/js/vendor.js'

    # grunt watch
    watch:
      all:
        files: ['<%= srcFolder %>/**/*.{coffee,scss,css,html}', 'Gruntfile.coffee']
        tasks: TASKS


    grunt.loadNpmTasks('grunt-contrib-jst')
    grunt.loadNpmTasks('grunt-contrib-coffee')
    grunt.loadNpmTasks('grunt-contrib-sass')
    grunt.loadNpmTasks('grunt-contrib-concat')
    grunt.loadNpmTasks('grunt-contrib-clean')
    grunt.loadNpmTasks('grunt-contrib-uglify')
    grunt.loadNpmTasks('grunt-contrib-watch')

  # tasks
  grunt.registerTask 'default', TASKS
