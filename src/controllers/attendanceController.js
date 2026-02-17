const Attendance = require('../models/Attendance');

exports.markAttendance = async (req, res) => {
    try {
        const attendance = new Attendance(req.body);
        const saved = await attendance.save();
        res.status(201).json(saved);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};

exports.getAttendanceBySession = async (req, res) => {
    try {
        const list = await Attendance.find({ sessionId: req.params.sessionId })
            .populate('memberId');
        res.status(200).json(list);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};
