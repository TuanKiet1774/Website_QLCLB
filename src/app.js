const express = require('express');
const cors = require('cors');
const connectDB = require('./config/db');

// Import Routes
const memberRoutes = require('./routes/memberRoutes');
const sessionRoutes = require('./routes/sessionRoutes');
const attendanceRoutes = require('./routes/attendanceRoutes');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use('/api/members', memberRoutes);
app.use('/api/sessions', sessionRoutes);
app.use('/api/attendance', attendanceRoutes);

app.get('/', (req, res) => {
    res.send('Website Quản lý CLB API is running...');
});

module.exports = app;
