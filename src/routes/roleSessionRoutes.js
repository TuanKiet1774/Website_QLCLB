const express = require('express');
const router = express.Router();
const roleSessionController = require('../controllers/roleSessionController');

router.get('/', roleSessionController.getAllRoleSessions);
router.post('/', roleSessionController.createRoleSession);

module.exports = router;
