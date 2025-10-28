const express = require('express');
const router = express.Router();
const db = require('../config/database');

router.get('/', async (req, res) => {
    try {
        const category = req.query.category;
        let query = 'SELECT * FROM projects';
        let params = [];

        if (category && category !== 'all') {
            query += ' WHERE category = ?';
            params.push(category);
        }

        query += ' ORDER BY year DESC, created_at DESC';

        const [projects] = await db.query(query, params);

        // Get unique categories
        const [categories] = await db.query('SELECT DISTINCT category FROM projects ORDER BY category');

        res.render('projects', {
            title: 'Projects - Minimalist Architecture',
            appName: 'Minimalist Architecture',
            projects: projects,
            categories: categories,
            selectedCategory: category || 'all'
        });
    } catch (error) {
        console.error('Error fetching projects:', error);
        res.render('projects', {
            title: 'Projects - Minimalist Architecture',
            appName: 'Minimalist Architecture',
            projects: [],
            categories: [],
            selectedCategory: 'all'
        });
    }
});

router.get('/:id', async (req, res) => {
    try {
        const [project] = await db.query('SELECT * FROM projects WHERE id = ?', [req.params.id]);

        if (project.length === 0) {
            return res.redirect('/projects');
        }

        res.render('project-detail', {
            title: project[0].title + ' - Minimalist Architecture',
            appName: 'Minimalist Architecture',
            project: project[0]
        });
    } catch (error) {
        console.error('Error fetching project:', error);
        res.redirect('/projects');
    }
});

module.exports = router;
