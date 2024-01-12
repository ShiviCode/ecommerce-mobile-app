import { Schema, model } from 'mongoose';
//import { v1 } from 'uuid';
//import { genSaltSync, hashSync } from 'bcrypt';

const productSchema = Schema({
    category: { type: Schema.Types.ObjectId, ref: 'Category', required: true, },
    title: { type: String, required: [true, "title is required, pls provide"] },
    description: { type: String, default: '', },
    price: { type: Number, required: true, },
    images: { type: Array, default: [], },
    updatedOn: { type: Date, },
    createdOn: { type: Date, }

});

productSchema.pre('save', function (next) {
    this.updatedOn = new Date();
    this.createdOn = new Date();

    next(); // if next has string that mean it has error
});

productSchema.pre(['update', 'findOneAndUpdate'], function (next) {
    const update = this.getUpdate();

    this.updatedOn = new Date();
    next();
});

const productModel = model('Product', productSchema);

//module.exports = productModel;
export default productModel;