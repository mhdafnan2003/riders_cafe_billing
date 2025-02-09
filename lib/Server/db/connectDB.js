import mongoose from 'mongoose';

export const connectDB = async () => {  

    try {
        const conn = await mongoose.connect(process.env.MONGOOSE_URL)
        console.log(`MongoDB Connected: ${conn.connection.host}`)
    } catch (error) {

        console.error('Error in DB connection',error)
        process.exit(1)

        
    }
}