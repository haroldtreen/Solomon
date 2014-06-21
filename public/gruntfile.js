module.exports = function(grunt) {

	grunt.initConfig({
		connect: {
			server: {
				options: {
					port: 9000, //run on port 9000
					open: true //open browser					
				}
			}
		},
		jshint: {
			all: ['scripts/*.js']
		},
		//compile Sass
		sass: { // Task                              
			dist: { // Target  
				options: { // Target options
					style: 'expanded'
				},
				files: {   // Dictionary of files
					'styles/style.css': 'styles/style.scss'       // 'destination': 'source
				}
			}
		},
		//autoprefix CSS
		autoprefixer: {
			options: {
				cascade: true
			},
			single_file: {
				src: 'styles/style.css',
				dest: 'styles/style.css'
			}
		},
		//watch file changes and recompile if necessary
		watch: {
			css: {//task
			    files: '**/*.scss', //where to watch
			    tasks: ['sass','autoprefixer'], 
			    options: {
			      livereload: true
			    }
			},
			javascript: {
				files: ['**/*.js'],
				tasks: ['jshint'],
				options: {
					livereload: true
				}
			}
		}
	});

//uglify, concat, minify needed.
	
	grunt.loadNpmTasks('grunt-contrib-jshint');
	grunt.loadNpmTasks('grunt-contrib-sass');
	grunt.loadNpmTasks('grunt-autoprefixer');
	grunt.loadNpmTasks('grunt-contrib-connect');
	grunt.loadNpmTasks('grunt-contrib-watch');

	//default task grunt will run...
	grunt.registerTask('default', ['jshint','connect','sass','autoprefixer','watch']);

};