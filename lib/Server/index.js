import express from 'express';
import dotenv from 'dotenv';
import { connectDB } from './db/connectDB.js';
import AuthRoute from './route/authRoutes.js';
import DashRoute from './route/DashboardRoute.js';
import cors from 'cors';


const app = express()

dotenv.config()

app.use(cors());


app.use(express.json())

app.use('/api/auth',AuthRoute)
app.use('/api/dashboard',DashRoute)

const startServer = async ()=>{
    try {
        await connectDB()
        app.listen(3000,()=>{
            console.log('Server is running on port 3000')
        })

    }
    catch (error) {
        console.error('Error in Connection',error)
    }

}

startServer()

