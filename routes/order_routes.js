import express from 'express';
import OrderController from '../controllers/order_controller.js';

const orderRoutes = express.Router();

orderRoutes.post('/', OrderController.createOrder);
orderRoutes.get('/:userId', OrderController.fetchOrdersForUser);
orderRoutes.put('/updateStatus', OrderController.updateOrderStatus);

//module.exports = orderRoutes;
export default orderRoutes;