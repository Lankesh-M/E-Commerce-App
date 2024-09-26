const express = require("express");
const User = require('../models/user')
const jwt = require('jsonwebtoken')
// Routers
const authRouter = express.Router();

// Other packages
const bcrypt = require('bcryptjs');

//SIGN UP ROUTE
authRouter.post('/api/signup', async (req, res) => {

    //Use try catch block
    const {name, email, password} = req.body;
    const existingUser = await User.findOne( { email } );

    if(existingUser) {
        return res.status(400).json({"msg" : "User with the same email is already exist"})
    }
    if (!name || !email || !password) {
        return res.status(400).json({ message: 'Name, email, and password are required.' });
    }

    const hashedPass =  await bcrypt.hash(password, 8);

    let user = new User(
        {
            name,
            email,
            password : hashedPass,
        }
    )

    user = await user.save();
    res.status(200).json(user);
})


//SIGN IN ROUTE
authRouter.post('/api/signin', async (req, res) => {
    try{
        const {email, password} = req.body;

        const user = await User.findOne({ email });
        // console.log(user._doc); 
        if(!user) {
            res.status(400).json({ msg : "User with this email does not exits."});
            return;
        }

        const isMatch = await bcrypt.compare(password, user.password);

        if(!isMatch) {
            res.status(400).json({ msg : "Password is Incorrect."});
            return;
        }
        const token = jwt.sign({ id: user._id }, "passwordKey");
        res.json({ token, ...user._doc });
    }catch(e){
        res.status(500).json({ error : e.message + " catch" })
    }
});
module.exports = authRouter;