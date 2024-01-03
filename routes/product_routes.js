import express from 'express';
import ProductController from '../controllers/product_controller.js';

const productRoutes = express.Router();
productRoutes.post('/', ProductController.createProduct);
productRoutes.get('/', ProductController.fatchAllProducts);
productRoutes.get('/category/:id', ProductController.fatchProductByCategory);

//module.exports = productRoutes;
export default productRoutes;
