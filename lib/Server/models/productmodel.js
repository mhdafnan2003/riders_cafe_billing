import mongoose from "mongoose";

const ProductSchema = new mongoose.Schema({
    name:{
        type:String,
        required:true,
        unique: true
    },
    description:{
        type:String,
    },
    category:{
        type:String,
        enum: ['Full Face Helmets', 'Half Face Helmets', 'Offroad Helmets','Accessories']
    },
    price:{
        type:Number,
        required:true
    },
    quantity:{
        type:Number,
        required:true

    }
},{timestamps:true})

export const Product = mongoose.model('Product',ProductSchema);