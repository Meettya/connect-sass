Connect/express middelware for rendering SASS/SCSS. Basic usage is as follows:

    express = require('express');
    sass = require('connect-sass');

    app = express();
    app.use('/css/app.css', sass.serve('sass/app.sass'));
    app.listen(3000);
