import { Schema, model } from 'mongoose';
//import { v1 } from 'uuid';
//import { genSaltSync, hashSync } from 'bcrypt';

const cartItemSchema = new Schema({
    product: { type: Schema.Types.ObjectId, ref: 'Product', },
    quantity: { type: Number, default: 1, }
    // updatedOn: { type: Date, },
    // createdOn: { type: Date, }
});

const cartSchema = Schema({
    user: { type: Schema.Types.ObjectId, ref: 'User', required: true, },
    items: { type: [cartItemSchema], default: [] },
    updatedOn: { type: Date, },
    createdOn: { type: Date, }

});

cartSchema.pre('save', function (next) {
    this.updatedOn = new Date();
    this.createdOn = new Date();

    next(); // if next has string that mean it has error
});

cartSchema.pre(['update', 'findOneAndUpdate'], function (next) {
    const update = this.getUpdate();
    delete update._id;//?

    this.updatedOn = new Date();
    next();
});

const cartModel = model('Cart', cartSchema);

//module.exports = cartModel;
export default cartModel;