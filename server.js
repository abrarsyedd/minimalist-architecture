const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;
const APP_NAME = process.env.APP_NAME || 'Minimalist Architecture';

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, 'public')));

// Set view engine
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Routes
const homeRoutes = require('./routes/home');
const aboutRoutes = require('./routes/about');
const projectsRoutes = require('./routes/projects');
const servicesRoutes = require('./routes/services');
const contactRoutes = require('./routes/contact');

app.use('/', homeRoutes);
app.use('/about', aboutRoutes);
app.use('/projects', projectsRoutes);
app.use('/services', servicesRoutes);
app.use('/contact', contactRoutes);

// 404 handler
app.use((req, res) => {
    res.status(404).render('404', { 
        title: 'Page Not Found - Minimalist Architecture',
        appName: APP_NAME 
    });
});

// Start server
app.listen(PORT, () => {
    console.log(`\n${'='.repeat(60)}`);
    console.log(`✨ ${APP_NAME} - Premium Design Studio`);
    console.log(`🚀 Server running at http://localhost:${PORT}`);
    console.log(`${'='.repeat(60)}\n`);
});
