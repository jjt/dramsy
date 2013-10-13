module.exports = function(grunt) {
  grunt.initConfig({
    express: {
      dev: {
        options: {
          script: 'app.coffee',
          cmd: 'coffee',
          error: function(err, res, code) {
            console.log(err, res, code);
          }
        }
      }
    },
    watch: {
      express: {
        files: ['**/*.coffee'],
        tasks: ['express:dev'],
        options: {
          nospawn: true
        }
      }
    }
  });
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-express-server');
  return grunt.registerTask('server', ['express:dev', 'watch']);
};
