import express from 'express';
import CategoryController from '../controllers/category_controller.js';

const categoryRoutes = express.Router();
categoryRoutes.post('/', CategoryController.createCategory);
categoryRoutes.get('/', CategoryController.fatchCategory);
categoryRoutes.get('/:id', CategoryController.fatchCategoryById);

export default categoryRoutes;