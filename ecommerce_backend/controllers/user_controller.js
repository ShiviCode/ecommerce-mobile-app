// const UserModel = require("./../models/user_model.js").default;
import UserModel from './../models/user_model.js';
import bcrypt from 'bcrypt';

const userController = {

    // createAccount: async function (req, res) { // express's request ,  express's response
    //        return res.json({message:'chal gaya'})
    //     // try {

    //     //     const userData = req.body;
    //     //     console.log(userData);
    //     //     const newUser = new UserModel(userData);
    //     //     await newUser.save();

    //     //     return res.json({ success: true, data: newUser, message: "User created!" });

    //     // } catch (e) {
    //     //     return res.json({ success: false, meaage: e });
    //     // }
    // }

    createAccount: async (req, res) => {
        try {
            const userData = req.body;
            console.log(userData);
            const newUser = new UserModel(userData);
            await newUser.save();

            return res.json({ success: true, data: newUser, message: "User created!" });

        } catch (e) {
            return res.json({ success: false, meaage: e });
        }
    },

    signIn: async (req, res) => {
        try {
            const userData = req.body;
            console.log(userData);

            const foundUser = await UserModel.findOne({ email: userData.email }); // get singal user that matches with given email
            console.log(foundUser);

            if (!foundUser) {
                return res.json({ success: false, message: "User not found!" });
            }
           //
            const isMatch = bcrypt.compareSync(userData.password, foundUser.password);// comparePassword(foundUser.password);
            if (!isMatch) {
                return res.json({ success: false, message: "Invalid password!" });
            }
            return res.json({ success: true, data: foundUser, message: "User logged in!" });
        } catch (e) {
            return res.json({ success: false, meaage: e });
        }
    },

    updateUser: async (req, res) => {
        try {
            const userId = req.params.userId;
            const updatedData = req.body;
            const updatedUser = await UserModel.findOneAndUpdate(
                { _id: userId },
                updatedData,
                { new: true }
            );

            if (!updatedUser) {
                throw "User not found";
            }

            return res.json({ success: true, data: updatedUser, message: "User updated!" });

        } catch (e) {
            return res.json({ success: false, meaage: e });
        }
    }


}

//module.exports = userController;
export default userController;