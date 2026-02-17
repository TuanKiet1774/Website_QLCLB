const mongoose = require('mongoose');

const memberSchema = new mongoose.Schema({
    mssv: {
        type: String,
        required: true,
        unique: true,
        trim: true
    },
    fullName: {
        type: String,
        required: true,
        trim: true
    },
    className: {
        type: String,
        trim: true
    },
    email: {
        type: String,
        trim: true,
        lowercase: true
    },
    passwordHash: {
        type: String,
        required: true
    },
    avatarPath: {
        type: String,
        default: ''
    },
    roleId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Role'
    },
    status: {
        type: String,
        default: 'Hoạt động'
    }
}, {
    timestamps: true,
    versionKey: false
});

// Thêm Indexes
memberSchema.index({ fullName: 'text', email: 'text' }); // Tìm kiếm văn bản (Search)
memberSchema.index({ roleId: 1 }); // Tối ưu khi lọc theo vai trò

module.exports = mongoose.model('Member', memberSchema);
