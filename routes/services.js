const express = require('express');
const router = express.Router();
const db = require('../config/database');

router.get('/', async (req, res) => {
    try {
        const [services] = await db.query('SELECT * FROM services ORDER BY id');

        res.render('services', {
            title: 'Services - Minimalist Architecture',
            appName: 'Minimalist Architecture',
            services: services
        });
    } catch (error) {
        console.error('Error fetching services:', error);
        res.render('services', {
            title: 'Services - Minimalist Architecture',
            appName: 'Minimalist Architecture',
            services: []
        });
    }
});

module.exports = router;
