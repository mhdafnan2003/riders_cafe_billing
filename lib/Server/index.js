import express from 'express';
import dotenv from 'dotenv';
import { connectDB } from './db/connectDB.js';
import AuthRoute from './route/authRoutes.js';


const app = express()

dotenv.config()

app.use(express.json())

app.use('/api/auth',AuthRoute)

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

//12kGtqpLX3eoJ4bG