//const categoryModel = require('./../models/category_model');
//import CategoryModel from './../models/category_model';
import ProductModel from './../models/product_model.js';


const ProductController = {

    createProduct: async function (req, res,) {
        try {

            const productData = req.body;
            const newProduct = new ProductModel(productData);
            await newProduct.save();

            return res.json({ success: true, data: newProduct, message: "Product created!" });

        } catch (e) {
            return res.json({ success: false, meaage: e });
        }
    },

    fatchAllProducts: async function (req, res,) {
        try {

            const products = await ProductModel.find(); // get all categories

            return res.json({ success: true, data: products });

        } catch (e) {
            return res.json({ success: false, meaage: e });
        }
    },

    fatchProductByCategory: async function (req, res,) {
        try {
            const categoryId = req.params.id; // category id
            const products = await ProductModel.find({ category: categoryId }); // get all products that matches category ID

            // if (!products) {
            //     return res.json({ success: false, meaage: 'Products not found in this category' });
            // }
            return res.json({ success: true, data: products });

        } catch (e) {
            return res.json({ success: false, meaage: e });
        }
    }

}

//module.exports = ProductController;
export default ProductController;