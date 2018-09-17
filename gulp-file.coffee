gulp			= require 'gulp'
gutil			= require 'gulp-util'
path			= require 'path'
PluginError		= gulp.PluginError

include			= require "gulp-include"
rename			= require "gulp-rename"
coffeescript	= require 'gulp-coffeescript'
sass 			= require 'gulp-sass'
pug				= require 'gulp-pug'
# babel			= require 'gulp-babel'

# compile sass
compileSass		= ->
	gulp.src ['assets/best-ui.sass', 'assets/best-ui-old.sass'], nodir: true
	.pipe sass().on 'error', sass.logError
	.pipe gulp.dest 'build'
	.on 'error', gutil.log


# compile coffee
compileCoffee	= ->
	gulp.src 'assets/best-ui.coffee', nodir: true
	.pipe include hardFail: true
	.pipe coffeescript(bare: true).on 'error', gutil.log
	# .pipe babel
	# 	presets: ['es2015']
	# 	plugins: ["async-to-promises"]
	.pipe gulp.dest 'build'

# compile documentation
compileDoc= ->
	gulp.src 'assets/**/doc.pug', nodir: true
	.pipe pug locals: {}
	.pipe gulp.dest 'build/doc'

# watch
watch =->
	gulp.watch 'assets/**/*.sass', compileSass
	gulp.watch 'assets/**/*.coffee', compileCoffee
	gulp.watch 'assets/**/*.pug', compileDoc

gulp.task 'default', gulp.series [
	gulp.parallel [compileSass, compileCoffee, compileDoc]
	watch
	]