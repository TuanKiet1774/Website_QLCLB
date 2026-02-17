const express = require('express');
const router = express.Router();
const attendanceController = require('../controllers/attendanceController');

router.post('/', attendanceController.markAttendance);
router.get('/session/:sessionId', attendanceController.getAttendanceBySession);

module.exports = router;
