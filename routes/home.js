const express = require('express');
const router = express.Router();
const db = require('../config/database');

router.get('/', async (req, res) => {
    try {
        // Get featured projects
        const [projects] = await db.query('SELECT * FROM projects ORDER BY created_at DESC LIMIT 3');

        res.render('home', {
            title: 'Home - Minimalist Architecture | Premium Design Studio',
            appName: 'Minimalist Architecture',
            projects: projects
        });
    } catch (error) {
        console.error('Error fetching data:', error);
        res.render('home', {
            title: 'Home - Minimalist Architecture',
            appName: 'Minimalist Architecture',
            projects: []
        });
    }
});

module.exports = router;
