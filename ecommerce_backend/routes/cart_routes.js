import express from 'express';
import CartController from '../controllers/cart_controller.js';

const cartRoutes = express.Router();

cartRoutes.get('/:user', CartController.getCartForUser);
cartRoutes.post('/', CartController.addToCart);
cartRoutes.delete('/', CartController.removeFromCart);

//module.exports = productRoutes;
export default cartRoutes;