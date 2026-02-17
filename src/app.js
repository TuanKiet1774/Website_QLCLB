const express = require('express');
const cors = require('cors');
const connectDB = require('./config/db');

// Import Routes
const authRoutes = require('./routes/authRoutes');
const memberRoutes = require('./routes/memberRoutes');
const sessionRoutes = require('./routes/sessionRoutes');
const attendanceRoutes = require('./routes/attendanceRoutes');
const roleRoutes = require('./routes/roleRoutes');
const roleSessionRoutes = require('./routes/roleSessionRoutes');

// Import Middleware
const auth = require('./middleware/authMiddleware');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/roles', roleRoutes);
app.use('/api/role-sessions', roleSessionRoutes);
app.use('/api/members', memberRoutes); // Yêu cầu đăng nhập để xem/quản lý thành viên
app.use('/api/sessions', sessionRoutes); // Yêu cầu đăng nhập để xem/quản lý buổi sinh hoạt
app.use('/api/attendance', attendanceRoutes); // Yêu cầu đăng nhập để điểm danh

app.get('/', (req, res) => {
    res.send('Website Quản lý CLB API is running...');
});

module.exports = app;
