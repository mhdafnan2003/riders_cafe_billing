import { User } from "../models/usermodel.js";
import jwt from "jsonwebtoken";
import bcrypt from "bcryptjs";


export const login = async (req, res) => {
    try {
        const { email, password } = req.body;

        // Find user by email
        const user = await User.findOne({ email });
        if (!user) return res.status(400).json({ message: "User not found" });

        // Compare entered password with stored hashed password
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) return res.status(400).json({ message: "Invalid credentials" });

        // Generate JWT token
        const token = jwt.sign(
            { userId: user._id, role: user.role },
            "secretkey",
            { expiresIn: "1h" }
        );

        return res.status(200).json({
            success: true,
            message: "Login successful",
            token,
            user: {
                name: user.name,
                email: user.email,
                role: user.role,
                _id: user._id
            }
        });
    } catch (error) {
        console.error("Login error:", error);
        return res.status(500).json({
            success: false,
            message: "Internal server error during login"
        });
    }
};

export const register = async (req, res) => {
    try {
        const { email, password, name, role } = req.body;
        
        // Log the incoming data
        console.log('Registration attempt:', {
            email,
            name,
            role,
            // Don't log password for security
        });

        if (!email || !password || !name || !role) {
            return res.status(400).json({
                success: false,
                message: 'Name, email, password, and role are required'
            });
        }

        const userexist = await User.findOne({ email });

        if (userexist) {
            return res.status(400).json({
                success: false,
                message: 'User already exists'
            });
        }

        const hashPassword = await bcrypt.hash(password, 10);

        // Create user with explicit role assignment
        const newUser = await User.create({
            name: name,
            email: email,
            password: hashPassword,
            role: role
        });

        // Log the created user (excluding password)
        console.log('User created:', {
            id: newUser._id,
            email: newUser.email,
            role: newUser.role,
            name: newUser.name
        });

        return res.status(201).json({
            success: true,
            message: 'User created successfully',
            user: {
                id: newUser._id,
                name: newUser.name,
                email: newUser.email,
                role: newUser.role
            }
        });

    } catch (error) {
        console.error('Signup error details:', {
            error: error.message,
            stack: error.stack,
            body: req.body
        });

        // Return more specific error messages
        if (error.name === 'ValidationError') {
            return res.status(400).json({
                success: false,
                message: 'Validation error',
                errors: Object.values(error.errors).map(err => err.message)
            });
        }

        return res.status(500).json({
            success: false,
            message: 'Internal server error during signup',
            error: error.message
        });
    }
}