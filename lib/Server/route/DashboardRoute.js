import express from 'express';
import { addProduct} from '../controllers/dashboardcontroller.js';

const route = express.Router();

route.post('/addproducts', addProduct);
export default route;