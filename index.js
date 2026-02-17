const express = require('express');
const mssql = require('mssql');
const cors = require('cors');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

// Cấu hình kết nối SQL Server
const config = {
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    server: process.env.DB_SERVER,
    database: process.env.DB_NAME,
    options: {
        encrypt: true, // Sử dụng cho Azure/Cloud
        trustServerCertificate: true // Sử dụng cho local phát triển
    }
};

// Hàm kết nối DB và lấy danh sách thành viên
app.get('/api/members', async (req, res) => {
    try {
        let pool = await mssql.connect(config);
        let result = await pool.request().query("SELECT * FROM Members");
        res.json(result.recordset);
    } catch (err) {
        res.status(500).send(err.message);
    }
});

// Endpoint mặc định
app.get('/', (req, res) => {
    res.send('API Quản lý CLB đang hoạt động!');
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
