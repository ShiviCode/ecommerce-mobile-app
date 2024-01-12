import { Schema, model } from 'mongoose';
import { v1 } from 'uuid';
import { genSaltSync, hashSync } from 'bcrypt';

const userSchema = Schema({
    id: { type: String, unique: true },
    fullName: { type: String, default: '', },
    email: { type: String, unique: true, requried: true },
    password: { type: String, required: true },
    phoneNumber: { type: String, default: '', },
    address: { type: String, default: '', },
    city: { type: String, default: '', },
    state: { type: String, default: '', },
    profileProgress: { type: Number, default: 0, },
    updatedOn: { type: Date, },
    createdOn: { type: Date, }

});

userSchema.pre('save', function (next) {
    this.id = v1();
    this.updatedOn = new Date();
    this.createdOn = new Date();

    const salt = genSaltSync(8);
    const hash = hashSync(this.password, salt);
    this.password = hash;
    next(); // if next has string that mean it has error
});

userSchema.pre(['update', 'findOneAndUpdate'], function (next) {
    const update = this.getUpdate();
    delete update._id;//?
    delete update.id;

    this.updatedOn = new Date();
    next();
});

// module.exports =  mongoose.model('user', userSchema);
const userModel = model('User', userSchema);

export default userModel;