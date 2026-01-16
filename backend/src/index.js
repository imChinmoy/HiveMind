import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
dotenv.config();


import authRouter from './routes/auth_router.js';

const app = express();
const PORT = process.env.PORT || 3000;
app.use(cors());
app.use(express.json());

app.use('/api/auth', authRouter);
// app.use('/api/chats', chatRouter);
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
