const express = require('express');
const router = express.Router();
const db = require('../config/database');

router.get('/', async (req, res) => {
    try {
        // Get team members
        const [team] = await db.query('SELECT * FROM team ORDER BY id');

        res.render('about', {
            title: 'About Us - Minimalist Architecture',
            appName: 'Minimalist Architecture',
            team: team
        });
    } catch (error) {
        console.error('Error fetching team data:', error);
        res.render('about', {
            title: 'About Us - Minimalist Architecture',
            appName: 'Minimalist Architecture',
            team: []
        });
    }
});

module.exports = router;
