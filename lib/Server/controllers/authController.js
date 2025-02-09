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
        const isMatch =  bcrypt.compare(password, user.password);
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
                email: user.email,
                role: user.role
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

export const register = async(req,res)=>{
    try {
        const {email, password, name} = req.body;
        
        if(!email || !password || !name){
            return res.status(400).json({ 
                success: false, 
                message: 'Name, email, and password are required' 
            });
        }

        const userexist = await User.findOne({email});

        if (userexist) {
            return res.status(400).json({ 
                success: false, 
                message: 'User already exists' 
            });
        }

        const hashPassword = await bcrypt.hash(password, 10);
        
        console.log('Attempting to create user with email:', email);
        
        const newUser = await User.create({
            name,
            email,
            password: hashPassword,
            
        });
        
        console.log('User created successfully:', newUser._id);

        return res.status(201).json({
            success: true, 
            message: 'User created successfully'
        });
        
    } catch (error) {
        console.error('Signup error details:', {
            error: error.message,
            stack: error.stack,
            body: req.body
        });
        
        return res.status(500).json({ 
            success: false, 
            message: 'Internal server error during signup',
            error: error.message
        });
    }
}