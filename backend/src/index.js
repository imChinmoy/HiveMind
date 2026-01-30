import dotenv from 'dotenv';
dotenv.config();
import express from 'express';
import cors from 'cors';
import morgan from 'morgan';


import authRouter from './routes/auth_router.js';
import serverRouter from './routes/server_router.js';

const app = express();



app.use(cors());
app.use(express.json());
app.use(morgan('dev'));
app.use(express.static('public'));

app.use('/api/auth', authRouter);
app.use('/api/servers', serverRouter);


// app.get('/', (req, res) => {
//     res.send({
//         status: 'success',
//         message: 'API is running',
//         data: null
//     });
// });

export default app;