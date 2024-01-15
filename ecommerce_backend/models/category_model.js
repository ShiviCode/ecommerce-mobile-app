import { Schema, model } from 'mongoose';
//import { v1 } from 'uuid';
//import { genSaltSync, hashSync } from 'bcrypt';

const categorySchema = Schema({
    title: { type: String, required: [true, "title is required, pls provide"] },
    description: { type: String,  requried: [true, "description is required, pls provide"], },
    updatedOn: { type: Date, },
    createdOn: { type: Date, }

});

categorySchema.pre('save', function (next) {
    this.updatedOn = new Date();
    this.createdOn = new Date();

    next(); // if next has string that mean it has error
});

categorySchema.pre(['update', 'findOneAndUpdate'], function (next) {
    const update = this.getUpdate();
    delete update._id;//?

    this.updatedOn = new Date();
    next();
});

const categoryModel = model('Category', categorySchema);

//module.exports = categoryModel;
export default categoryModel;