const mysql = require('mysql2');
require('dotenv').config();

// Create connection pool for Minimalist Architecture
const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

// Get promise-based connection
const promisePool = pool.promise();

// Test connection
pool.getConnection((err, connection) => {
    if (err) {
        console.error('❌ Error connecting to database:', err.message);
        console.log('Please ensure MySQL is running and credentials in .env are correct');
    } else {
        console.log('✓ Successfully connected to Minimalist Architecture database');
        connection.release();
    }
});

module.exports = promisePool;
