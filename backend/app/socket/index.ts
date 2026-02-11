import { Server } from 'socket.io';
import http from 'http';
import { app } from '../api/app.js';
import { socketRegisterHandlers } from './socket.js';

const server = http.createServer(app);
const io = new Server(server, {
    cors: {
        origin: "*",
        methods: ["GET", "POST"]
     }
});

socketRegisterHandlers(io);

export default server;