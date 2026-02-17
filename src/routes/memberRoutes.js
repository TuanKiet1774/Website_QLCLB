const express = require('express');
const router = express.Router();
const memberController = require('../controllers/memberController');

router.get('/stats', memberController.getMemberStats);
router.get('/', memberController.getAllMembers);
router.post('/', memberController.createMember);
router.get('/:id', memberController.getMemberById);

module.exports = router;
