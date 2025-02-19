

// productController.js
import { Product } from '../models/productmodel.js';
import { User } from '../models/usermodel.js';

export const addProduct = async (req, res) => {
    try {
        const { name, description, category, price, quantity } = req.body;
        
        // Validate required fields
        if (!name || !category || !price || !quantity) {
            return res.status(400).json({
                success: false,
                message: 'Please provide all required fields'
            });
        }

        // Validate category
        const validCategories = ['Full Face Helmets', 'Half Face Helmets', 'Offroad Helmets', 'Accessories'];
        if (!validCategories.includes(category)) {
            return res.status(400).json({
                success: false,
                message: 'Invalid category'
            });
        }

        // Create new product
        // Note: In production, you'd get the user ID from the authenticated session
        const product = new Product({
            name,
            description,
            category,
            price: Number(price),
            quantity: Number(quantity),
           
        });

        // Save the product
        await product.save();

        // Update the user's products array
        await User.findByIdAndUpdate(
            req.User._id,
            { $push: { products: product._id } }
        );

        res.status(201).json({
            success: true,
            message: 'Product added successfully',
            data: product
        });

    } catch (error) {
        if (error.code === 11000) { // Duplicate key error
            return res.status(400).json({
                success: false,
                message: 'Product with this name already exists'
            });
        }

        res.status(500).json({
            success: false,
            message: 'Error adding product',
            error: error.message
        });
    }
};

