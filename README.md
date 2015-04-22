karaokeplaylist
===============

A Collaborative Online YouTube Karaoke Room
Demo at http://karaokeplaylist.net

## Usage

### Clone and Enter the Repo
```
git clone https://github.com/perspectivezoom/karaokeplaylist.git
cd karaokeplaylist
```

### Install Dependencies
```
npm install
jspm install
```

### Build and Start the Dev Server
```
gulp serve
```
Builds from `src` into `dev` and starts BrowserSync.
Note: This project uses gulp 4. If you don't have gulp 4 globally installed, or [have not aliased the gulp command](https://github.com/greypants/gulp-starter/blob/master/README.md#the-gulp-command) to the local repo, you will need to use `./node_modules/.bin/gulp serve` instead.

### Generate a Production Build
```
gulp clean
gulp dev
gulp prod
```
Builds from `dev` into `prod`, minifying css, js, and images.

## Acknowledgements

Built from [gulp-jspm-react-coffee-starter](https://github.com/perspectivezoom/gulp-jspm-react-coffee-starter)

Large portions of this repo were more or less copied from:

* [Glen Maddern's post and screencast](http://glenmaddern.com/articles/javascript-in-2015), for explaining [JSPM](http://jspm.io) and how it might be better than [Browserify](http://browserify.org/) as it need not pre-compile.
* [Gulp Starter](https://github.com/greypants/gulp-starter), for showing how to split tasks across files, and for most of the tasks.
* [This post](http://demisx.github.io/gulp4/2015/01/15/install-gulp4.html) to get Gulp 4 working and take advantage of `gulp.series` and `gulp.parallel`
* [This post](http://pem-musing.blogspot.com/2014/02/a-gulp-of-coffee-your-gulpfile-in.html) to get coffeescript Gulp tasks working
* [HTML5 Boilerplate](https://github.com/h5bp/html5-boilerplate)
* [normalize.css](http://necolas.github.io/normalize.css/)

## License
MIT. Go nuts.