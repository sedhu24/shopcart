var express = require("express");
const bcryptjs = require("bcryptjs");
const User = require("../models/user");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");


const authRouter = express.Router();



// SignUp

authRouter.post("/api/signup",async (req,res)=>{

    try{
        const {name, email, password,} = req.body;

        const existingUser = await User.findOne({email});
    
        if(existingUser ){
            return res.status(400).json({msg : 'User with same email already Exists! '});
        }

     const hashedpassword =  await bcryptjs.hash(password, 8);
    
        let user = new User({
            email,
            password: hashedpassword,
            name,
        });
    
        user = await user.save();
    
        res.json({user});
    }
    catch(e)
    {
        res.status(500).json({error:e.message});
    }
    // Steps =>:
    // geting Data
    // Posting Data
    // return the data

});

authRouter.post("/api/signin", async (req,res) => {


    try{

    const {email,password,} = req.body;

    const user = await User.findOne({email});
    if(!user){
        return res.status(400).json({msg:"User with this email does not Exists"},);
    }
     const isMatched = await  bcryptjs.compare(password, user.password);

     if(!isMatched){
        return res.status(400).json({msg:"Incorrect Password"},);
     }

   const token =  jwt.sign({id: user._id},"paswordkey");
   res.json({token, ...user._doc})

    }
    catch(e){
         res.status(500).json({error:e.message});
    }

});

authRouter.post("/tokenIsValid",async(req,res)=>{
    try{

        const  token = req.header("x-auth-token");
        if(!token){
            return res.json(false);
        }

        const verified = jwt.verify(token,'paswordkey');

        if(!verified) return res.json(false);

        const user = await User.findById(verified.id);

        if(!user) return res.json(false);

        res.json(true);




    }
    catch(e){
        res.status(500).json({error:e.message});
    }
});

// get User Data 

authRouter.get("/", auth ,async(req,res)=>{
const user = await User.findById(req.user);
res.json({...user._doc, token:req.token});
} );



module.exports = authRouter;


