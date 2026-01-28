import express from 'express';
import { createServer, getServers, joinServer } from '../controllers/server_controller.js';
import { authenticate } from '../middlewares/auth.middleware.js';

const router = express.Router();

router.post('/create', authenticate, createServer);
router.post('/join', authenticate, joinServer);
router.get('/me', authenticate, getServers);


export default router;