const mongoose = require('mongoose');
const authRouter = require('../routes/auth');

const userScheme = mongoose.Schema({
    name:{
        required: true,
        type: String,
        trim: true,
    },
    email:{
        required: true,
        type: String,
        trim: true,
        validate:{
            validator:(value) =>{
               const reg = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/i; 
               return value.match(reg);
            },
            message: 'Please Enter a valid Email Address',
        }
    },
    password:{
        required:true,
        type:String,
    },
    address:{
        type:String,
        default:'',
    },
    type:{
        type:String,
        default:'user',
    }

});


const User = mongoose.model('User', userScheme);

module.exports = User;