const Session = require('../models/Session');

exports.getAllSessions = async (req, res) => {
    try {
        const sessions = await Session.find()
            .populate('instructors.memberId')
            .populate('instructors.roleSessionId');
        res.status(200).json(sessions);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

exports.createSession = async (req, res) => {
    try {
        const newSession = new Session(req.body);
        const savedSession = await newSession.save();
        res.status(201).json(savedSession);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};
