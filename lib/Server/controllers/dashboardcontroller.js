import mongoose from "mongoose";
import { Product } from '../models/productmodel.js'

export const addproducts = async (req, res) => {

    try {

        const { name, description, category, price, quantity } = req.body;
        if (!name || !category || !price || !quantity) {
            return res.status(400).json({
                success: false,
                message: 'Name, Category, Price, and Quantity are required'
            });
        }

        const user = await Product.findOne({ name });
        if (user) return res.status(400).json({ message: "Product Already Exist" });

        const newProduct = await Product.create({
            name,
            description,
            category,
            price,
            quantity
        })

        console.log('Product created', {
            name: newProduct.name,
            description: newProduct.description,
            category: newProduct.category,
            price: newProduct.price,
            quantity: newProduct.quantity
        })

        return res.status(201).json({
            success: true,
            message: 'Product created successfully',
            user: {
                name: newProduct.name,
                description: newProduct.description,
                category: newProduct.category,
                price: newProduct.price,
                quantity: newProduct.quantity
            }
        });




    } catch (error) {
        console.error('Add Products error details:', {
            error: error.message,
            stack: error.stack,
            body: req.body
        });

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