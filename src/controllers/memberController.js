const Member = require('../models/Member');

// Lấy tất cả thành viên
exports.getAllMembers = async (req, res) => {
    try {
        const members = await Member.find().populate('roleId');
        res.status(200).json(members);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// Tạo thành viên mới
exports.createMember = async (req, res) => {
    try {
        const newMember = new Member(req.body);
        const savedMember = await newMember.save();
        res.status(201).json(savedMember);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};

// Lấy chi tiết 1 thành viên
exports.getMemberById = async (req, res) => {
    try {
        const member = await Member.findById(req.params.id).populate('roleId');
        if (!member) return res.status(404).json({ message: 'Không tìm thấy thành viên' });
        res.status(200).json(member);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};
