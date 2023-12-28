//const categoryModel = require('./../models/category_model');
//import CategoryModel from './../models/category_model';
import CategoryModel from './../models/category_model.js';


const CategoryController = {

    createCategory: async function (req, res,) {
        try {

            const categoryData = req.body;
            const newCategory = new CategoryModel(categoryData);
            await newCategory.save();

            return res.json({ success: true, data: newCategory, message: "Category created!" });

        } catch (e) {
            return res.json({ success: false, meaage: e });
        }
    },

    fatchCategory: async function (req, res,) {
        try {

            const categories = await CategoryModel.find(); // get all categories

            return res.json({ success: true, data: categories });

        } catch (e) {
            return res.json({ success: false, meaage: e });
        }
    },

    fatchCategoryById: async function (req, res,) {
        try {
            const id = req.params.id;
            const foundCategory = await CategoryModel.findById(id); // get all categories

            if(!foundCategory){
                return res.json({ success: false, meaage: 'Category not found' });
            }
            return res.json({ success: true, data: foundCategory });

        } catch (e) {
            return res.json({ success: false, meaage: e });
        }
    }

}

//module.exports = CategoryController;
export default CategoryController;