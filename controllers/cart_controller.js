import CartModel from "../models/cart_model.js";

const CartController = {

    getCartForUser: async function (req, res) {
        // console.log("get cart user");
        // console.log(req.params.user);
        // const user = req.params.user;
        // const foundCart = await CartModel.findOne({ user: user });
        // return res.json({uccess: true, data: foundCart.items, message: "Cart Items"})
        try {
            const user = req.params.user;
            const foundCart = await CartModel.findOne({ user: user });

            if (!foundCart) {
                return res.json({ success: true, data: [], message: "Cart not exists" });
            }
            return res.json({ success: true, data: foundCart.items, message: "Cart Items" });
        }
        catch (e) {
            return res.json({ success: false, meaage: 'somethinf' });
        }
    },

    addToCart: async function (req, res) {
        try {
            const { product, user, quantity } = req.body;

            const foundCart = await CartModel.findOne({ user: user });
            if (!foundCart) {
                const newCart = new CartModel({ user: user, });
                newCart.items.push({
                    product: product,
                    quantity: quantity
                });

                await newCart.save();
                return res.json({ success: true, data: newCart, message: "Product added to cart!" });
            }
            // if cart already exists
            const upatedCart = await CartModel.findOneAndUpdate(
                { user: user },// matches by user
                { $push: { items: { product: product, quantity: quantity } } }, // update
                { new: true } // if true this will return updated model
            );
            // await upatedCart.save();
            return res.json({ success: true, data: upatedCart, message: "Product added to cart!" });
        }
        catch (e) {
            return res.json({ success: false, meaage: e });
        }
    },

    removeFromCart: async function (req, res) {
        try {

            const { product, user } = req.body;
            const updatedCart = await CartModel.findOneAndUpdate(
                { user: user },// condition
                { $pull: { items: { product: product } } },
                { new: true }
            );
            return res.json({
                success: true, data: updatedCart, message: "Product removed from cart!"
            });

        }
        catch (e) {
            return res.json({ success: false, meaage: e });
        }
    }

}

export default CartController;