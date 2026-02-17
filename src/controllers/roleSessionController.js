const RoleSession = require('../models/RoleSession');

exports.getAllRoleSessions = async (req, res) => {
    try {
        const roleSessions = await RoleSession.find().lean();
        res.status(200).json(roleSessions);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

exports.createRoleSession = async (req, res) => {
    try {
        const newRoleSession = new RoleSession(req.body);
        const savedRoleSession = await newRoleSession.save();
        res.status(201).json(savedRoleSession);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};
