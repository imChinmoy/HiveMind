import express from 'express';
import { createServer } from '../controllers/server_controller.js';
import { authenticate } from '../middlewares/auth.middleware.js';

const router = express.Router();

router.post('/create', authenticate, createServer);
router.post('/join', (req, res) => res.status(200).json({ message: 'Join server successfully.' }));
export default router;