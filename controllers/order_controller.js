import OrderModel from "../models/order_model.js";

const OrderController = {

    createOrder: async function (req, res) {
        try {
            const { user, items, } = req.body;
            const newOrder = await OrderModel({
                user: user,
                items: items
            });

            await newOrder.save();
            return res.json({ success: true, data: newOrder, message: "Order created!" });
        }
        catch (e) {
            return res.json({ success: false, meaage: 'somethinf' });
        }
    },

    fetchOrdersForUser: async function (req, res) {
        try {
            const userId = req.params.userId;

            const foundOrders = await OrderModel.find({
                "user.id": userId
            });
            return res.json({ success: true, data: foundOrders, message: "List of Orders" });
        }
        catch (e) {
            return res.json({ success: false, meaage: e });
        }
    },

    updateOrderStatus: async function (req, res) {
        try {

            const { orderId, status } = req.body;
            const updatedOrder = await OrderModel.findOneAndUpdate(
                { _id: orderId },// condition
                { status: status },
                { new: true }
            );
            return res.json({
                success: true, data: updatedOrder, message: "Updated orders"
            });

        }
        catch (e) {
            return res.json({ success: false, meaage: e });
        }
    }

}

export default OrderController;