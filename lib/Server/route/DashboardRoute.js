import express from 'express';
import { addproducts } from '../controllers/dashboardcontroller.js';

const route = express.Router();

route.post('/addproducts',addproducts)

export default route;