import { Schema, model } from 'mongoose';
//import { v1 } from 'uuid';
//import { genSaltSync, hashSync } from 'bcrypt';

const orderItemSchema = new Schema({
    product: { type: Map, required: true },
    quantity: { type: Number, default: 1, }
    // updatedOn: { type: Date, },
    // createdOn: { type: Date, }
});

const orderSchema = Schema({
    user: { type: Map, required: true, },
    items: { type: [orderItemSchema], default: [] },
    status: { type: String, default: "order-placed" },
    updatedOn: { type: Date, },
    createdOn: { type: Date, }

});

orderSchema.pre('save', function (next) {
    this.updatedOn = new Date();
    this.createdOn = new Date();

    next(); // if next has string that mean it has error
});

orderSchema.pre(['update', 'findOneAndUpdate'], function (next) {
    const update = this.getUpdate();
    delete update._id;//?

    this.updatedOn = new Date();
    next();
});

const orderModel = model('Order', orderSchema);

//module.exports = orderModel;
export default orderModel;