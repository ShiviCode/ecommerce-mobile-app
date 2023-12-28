import express from 'express';
import userController from './../controllers/user_controller.js';

const userRouter = express.Router();

userRouter.post('/createAccount', userController.createAccount);
userRouter.post('/signIn', userController.signIn);


export default userRouter;
// export default  router;