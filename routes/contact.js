const express = require('express');
const router = express.Router();
const db = require('../config/database');

router.get('/', (req, res) => {
    res.render('contact', {
        title: 'Contact Us - Minimalist Architecture',
        appName: 'Minimalist Architecture',
        success: req.query.success === 'true'
    });
});

router.post('/', async (req, res) => {
    try {
        const { name, email, phone, subject, message } = req.body;

        await db.query(
            'INSERT INTO contacts (name, email, phone, subject, message) VALUES (?, ?, ?, ?, ?)',
            [name, email, phone, subject, message]
        );

        res.redirect('/contact?success=true');
    } catch (error) {
        console.error('Error saving contact:', error);
        res.render('contact', {
            title: 'Contact Us - Minimalist Architecture',
            appName: 'Minimalist Architecture',
            success: false,
            error: 'Failed to submit form. Please try again.'
        });
    }
});

module.exports = router;
