import mongoose from 'mongoose';

const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
        unique: true
    }, 
    password: {
        type: String,
        required: true
    },
    role: {
        type: String,
        required: true,
        enum: ['Super Admin', 'Admin', 'User'] // Add all your role types here
    }
}, { timestamps: true });

export const User = mongoose.model('User', userSchema);